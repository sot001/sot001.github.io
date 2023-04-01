---
title: mysql-keeping-your-password-safe
date: '2023-04-01 19:37:57 +0000'
categories:
- mysql-keeping-your-password-safe
tags:
- mysql-keeping-your-password-safe
---


[category: security](category:_security "wikilink") [category:
mysql](category:_mysql "wikilink")

use
[mysql_config_editor](https://dev.mysql.com/doc/refman/5.6/en/mysql-config-editor.html)

usage;

    $  mysql_config_editor set --login-path=somelabel --port=someport --host=somehost --user=someuser --password

stores login details in an encrypted file

show all configurations stored in file

`mysql_config_editor print --all`

connect with ;

`mysql --login-path=somelabel`

..boom..