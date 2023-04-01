## Grep for whole words;

eg. get only those lines with itunes or MongoDB in them

`grep "itunes\|MongoDB" dblist.txt`

## Get 3 lines Before the pattern

`grep -B 3 identities_root ~/.aws/config`

## Get 3 lines After the pattern

`grep -B 3 -A 3 identities_root ~/.aws/confi`