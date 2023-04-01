---
title: iredmail---forward-mail
date: '2023-04-01 19:37:56 +0000'
categories:
- iredmail---forward-mail
tags:
- iredmail---forward-mail
---


For MySQL backend, you can create new record in table "vmail.alias". for
example:

`mysql> UPDATE alias SET goto='user@external.com,another@external.com' WHERE username='user@your_domain';`

To forward a whole domain, insert a new record:

`insert into alias (address, goto, domain) values ('this.domain', 'user@external.com', 'this.domain');`