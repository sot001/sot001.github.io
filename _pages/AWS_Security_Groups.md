### finding unused security groups

(ref:
<https://stackoverflow.com/questions/24685508/how-to-find-unused-amazon-ec2-security-groups>)

First, get a list of all security groups

`aws ec2 describe-security-groups --query 'SecurityGroups[*].GroupId'  --output text | tr '\t' '\n'`

Then get all security groups tied to an instance, then piped to sort
then uniq:

`aws ec2 describe-instances --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text | tr '\t' '\n' | sort | uniq`

Then put it together and compare the 2 lists and see what's not being
used from the master list:

`comm -23  <(aws ec2 describe-security-groups --query 'SecurityGroups[*].GroupId'  --output text | tr '\t' '\n'| sort) <(aws ec2 describe-instances --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text | tr '\t' '\n' | sort | uniq)`