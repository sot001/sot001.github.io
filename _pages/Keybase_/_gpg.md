gpg keys can be stored in KFS via;

`keybase pgp push-private KEYHASH`

they can then be exported into the local machine gpg keychain via;

`keybase pgp pull-private`

If you have backed up private gpg keys on one server and transferred to
another, they will lose the 'trust' so will show up as '\[unknown\]'
when listing them. To fix this (if you trust the keys), edit the key and
change the trust level

`gpg --edit-key user@example.com`
`...`
`gpg> trust`
`... (select 5)`
`gpg> save`

should show up as '\[ulimate\]' now

### show keys in keyring

`gpg -k`

### exporting public key

`gpg --output ./my-public.key --armor --export user@example.com`

### import public key

from external.user@example.com

`gpg --import their-public.key`

If you trust it (check the fingerprint against what they sent you), then
sign it

`gpg --sign-key external.user@example.com`

### encrypting message to another user

`gpg --encrypt --sign --armor -r external.user@example.com filename`

### decrypting message from another user

`gpg --decrypt coded.asc > plain.txt`