---
title: aws-amazon-cli
date: '2023-04-01 19:37:55 +0000'
categories:
- aws-amazon-cli
tags:
- aws-amazon-cli
---


### Best Practices

  - configure a read only user for running discovery queries.
  - never use an admin account for changing things unless absolutely
    required. Better if you can use an account that is tailored to the
    function you wish to amend.

### install this on your workstation via pip.

`sudo pip install awscli`

After you've set up your keys, beware the trailing % on the password\!\!

`cat ../keys/rootkey.csv                    `
`AWSAccessKeyId=*****************3A`
`AWSSecretKey=****************************FO% `

Remove this character when you use AWS configure

### do a date search

eg. show me all medialive reservations that will expire in 7 days or
less

```
 aws medialive list-reservations --query 'Reservations[?End<=`$(date -v+7d)`].{Name:Name, Arn:Arn, Expires:End}'
```

### Get list of AMI's minus top 2

Say we wish to clear down AMI's but want to keep at least 2 in case our
build pipeline breaks. What we do is sort_by the CreationDate in
reverse order, which puts the most recent at the top then we slice off
the top 2 results and output what remains

This gets a list of AMI's sorted in reverse order;

```

╰─$ aws ec2 describe-images \
--query 'reverse(sort_by(Images, & CreationDate))[].{Name:Name, Id:ImageId, date:CreationDate}' \
--filters Name=owner-id,Values=1122334455 \
--filters 'Name=name,Values=AMZN2-AMI-HVM-2.0-BUILD-'

[
    {
        "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1634836088",
        "Id": "ami-0a543f4ffa33a97f1",
        "date": "2021-10-21T17:10:29.000Z"
    },
    {
        "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1635331158",
        "Id": "ami-0f4e86eb92448a227",
        "date": "2021-10-27T10:41:58.000Z"
    },
    {
        "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1635857252",
        "Id": "ami-020175c209d8efd33",
        "date": "2021-11-02T12:49:39.000Z"
    }
]
```

And this gets a list of AMI's sorted in reverse order missing the top
(most recent) two;

    ╰─$ aws ec2 describe-images \
    --query 'reverse(sort_by(Images, & CreationDate))[1:].{Name:Name, Id:ImageId, date:CreationDate}' \
    --filters Name=owner-id,Values=222622218059 \
    --filters 'Name=name,Values=AMZN2-AMI-HVM-2.0-BILSDALE-*'
    [
        {
            "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1635331158",
            "Id": "ami-0f4e86eb92448a227",
            "date": "2021-10-27T10:41:58.000Z"
        },
        {
            "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1634836088",
            "Id": "ami-0a543f4ffa33a97f1",
            "date": "2021-10-21T17:10:29.000Z"
        },
        {
            "Name": "AMZN2-AMI-HVM-2.0-BILSDALE-@1633683261",
            "Id": "ami-094e82d91da3fe0dc",
            "date": "2021-10-08T08:57:03.000Z"
        }
    ]

### Calculate S3 bucket size

    aws s3api list-objects --bucket BUCKET_NAME --output json \
    --query "[sum(Contents[].Size), length(Contents[])]" | awk 'NR!=2 {print $0;next} NR==2 {print $0/1024/1024/1024" GB"}'

### Copy RDS snapshots to another account from an existing automated snaphsot

`aws rds describe-db-snapshots \`
`--query "DBSnapshots[*].[DBSnapshotIdentifier,SnapshotCreateTime,DBSnapshotArn]" --output table`

`aws rds copy-db-snapshot \`
`--source-db-snapshot-identifier 'rds:mydb-2018-11-26-09-13' \`
`--target-db-snapshot-identifier 'mydb-2018-11-26-09-13-share' \`
`--copy-tags`

`aws rds modify-db-snapshot-attribute \ `
`--db-snapshot-identifier 'mydb-2018-11-26-09-13-share' \ `
`--attribute-name restore \ `
`--values-to-add '["44356781020"]'`

This next step is done from an EC2 instance spun up with the RDS role
(rds-backup-role) attached to it.

`aws --region eu-west-1 rds copy-db-snapshot \`
`--source-db-snapshot-identifier 'arn:aws:rds:us-east-1:56856789353:snapshot:mydb-2018-11-26-09-13-share' \`
`--target-db-snapshot-identifier 'dr-mydb-2018-11-26-09-13'`

### Current EC2 (minus spot) using for budgets

`aws --profile prod-readonly ec2 describe-instances \`
``--query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0], Tags[?Key==`billingGroup`].Value | [0], InstanceType,InstanceLifecycle]' \``
`--output table | egrep -v spot`

### Information on Active Reservations

`aws --profile prod-readonly ec2 describe-reserved-instances --filters Name=state,Values=active --query "ReservedInstances[*]. [ReservedInstancesId,End,InstanceType,InstanceCount,OfferingClass]" --output table`

### Listing RDS snapshot details

`aws --profile readonly rds describe-db-instances --query "DBInstances[*].{Name:DBInstanceIdentifier, Retention:BackupRetentionPeriod, Backup:PreferredBackupWindow}" --output table`

### Finding unused security groups

(ref:
<https://stackoverflow.com/questions/24685508/how-to-find-unused-amazon-ec2-security-groups>)

First, get a list of all security groups

`aws --profile readonly ec2 describe-security-groups --query 'SecurityGroups[*].GroupId' --output text | tr '\t' '\n'`

Then get all security groups tied to an instance, then piped to sort
then uniq:

`aws --profile readonly ec2 describe-instances --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text | tr '\t' '\n' | sort | uniq`

Then put it together and compare the 2 lists and see what's not being
used from the master list:

`comm -23 <(aws --profile readonly ec2 describe-security-groups --query 'SecurityGroups[*].GroupId' --output text | tr '\t' '\n'| sort) <(aws --profile readonly ec2 describe-instances  --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text | tr '\t' '\n' | sort | uniq) `

The same can be done with ELB's as the above only looks for EC2 security
groups. Here is the same for ELB's:

`comm -23 <(aws --profile readonly ec2 describe-security-groups --query "SecurityGroups[*].GroupId" --output text | tr '\t' '\n' | sort) <(aws --profile readonly elb describe-load-balancers --query "LoadBalancerDescriptions[*].SecurityGroups" --output text | tr '\t' '\n' | sort | uniq)`

### dumping out snapshot configuration into a tab delimited file for importing into google sheets (for eg.)

`aws --profile readonly ec2 describe-snapshots --query "Snapshots[*].{ID:SnapshotId, Time:StartTime, Size_in_GB:VolumeSize, Comments:Description}" --filters Name=owner-id,Values=56567849353 --output text > snapshot.csv`

Listing RDS snapshots

`aws --profile prod-readonly rds describe-db-snapshots --query "DBSnapshots[*].[MasterUsername,DBSnapshotIdentifier,SnapshotCreateTime,AllocatedStorage]" --output table`

### dumping out AMI info as previous

`aws --profile readonly ec2 describe-images --query "Images[*].{Name:Name, Id:ImageId, Comment:Description, Size:BlockDeviceMappings[0].Ebs.VolumeSize, date:CreationDate}" --filters Name=owner-id,Values=56856789353 --output text > ami.csv`

### getting all tags associated to an instance

`aws --profile readonly ec2 describe-instances \ `
`--query "Reservations[*].Instances[*].{ID:InstanceId, Tags:Tags[*]}" \`
`--output table`

    ----------------------------------------
    |           DescribeInstances          |
    +--------------------------------------+
    |                  ID                  |
    +--------------------------------------+
    |  i-0b456781138d8a1                 |
    +--------------------------------------+
    ||                Tags                ||
    |+---------------+--------------------+|
    ||      Key      |       Value        ||
    |+---------------+--------------------+|
    ||  Name         |  query-playback    ||
    ||  schedule     |  uk-office-hours   ||
    ||  billingGroup |  kristian-sandbox  ||
    ||  scheduler    |  started           ||
    |+---------------+--------------------+|

### retrieving selected tags

for example just getting the name and billing group tags

``aws --profile readonly ec2 describe-instances --query 'Reservations[].Instances[].{Id: InstanceId, Name: Tags[?Key==`Name`].Value | [0], Role: Tags[?Key==`billingGroup`].Value | [0]}' --output text | tr "\t" ","``

### Pulling back unique billingTag's 

`aws --profile prod-readonly ec2 describe-instances \`
``--query 'Reservations[].Instances[].{Role: Tags[?Key==`billingGroup`].Value | [0]}' \``
`--output text | tr "\t" "," | sort | uniq`

### Pulling back RDS endpoints

`aws --profile readonly rds describe-db-instances --query "DBInstances[].[DBInstanceIdentifier, Endpoint.Address]"`

### Finding snapshots that don't belong to existing instances or volumes 

First we look at the query to get back snapshot info belonging to us,
format sort and get only uniq values;

`aws --profile prod-readonly ec2 describe-snapshots --query "Snapshots[*].VolumeId" --filters Name=owner-id,Values=5685678353 --output text | tr "\t" "\n" | sort | uniq`

Based on that list, we can now query for volumes and instances. First
instances;

    for volid in $(aws --profile prod-readonly ec2 describe-snapshots --query "Snapshots[*].VolumeId" --filters Name=owner-id,Values=56856789353 --output text | tr "\t" "\n" | sort | uniq); do
        echo looking for $volid
        aws --profile prod-readonly ec2 describe-instances --query 'Reservations[].Instances[].{Id: InstanceId, Name: Tags[?Key==`Name`].Value | [0], Volume: BlockDeviceMappings[].Ebs.VolumeId}' --filters Name=block-device-mapping.volume-id,Values=$volid
        echo
    done
    ..
    looking for vol-accccdeb5
    []

    looking for vol-0662ccccc41ed4c8
    [
        {
            "Volume": [
                "vol-06cccccd41ed4c8"
            ],
            "Id": "i-025ccccc47c59df",
            "Name": "Robot Master"
        }
    ]

    looking for vol-d4cccd91
    []

    looking for vol-acccceb5
    []
    ...

### Get a csv list of instance name, size and billingtag

`aws --profile prod-readonly ec2 describe-instances \`
``--query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0], Tags[?Key==`billingGroup`].Value | [0], InstanceType]' \``
`--output text | tr "\t" ","`

### Create launch configuration

`AWS_PROFILE=prod-admin aws autoscaling create-launch-configuration \`
`--image-id ami-0a1cccc07b939b \`
`--instance-type m3.medium \`
`--iam-instance-profile myWeb \`
`--security-groups sg-434db339 \`
`--launch-configuration-name myWeb031-fix \`
`--block-device-mappings "[{\"DeviceName\": \"/dev/sda1\",\"Ebs\":{\"VolumeSize\":8, \"DeleteOnTermination\": true, \"SnapshotId\": \"snap-012928ccccffc986\", \"VolumeType\": \"gp2\"}}]" \`
`--key-name mykey \`
`--instance-monitoring Enabled=false \`
`--no-ebs-optimized \`
`--no-associate-public-ip-address`

### Use a "wildcard" in a search

``aws lambda list-functions --function-version ALL --query 'Functions[?starts_with(Runtime, `node`) == `true`].[Runtime,FunctionName]' --output table``

Looks for Runtime values starting with "node"

