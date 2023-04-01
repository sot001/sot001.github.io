---
title: reading-in-variables
date: '2023-04-01 19:37:57 +0000'
categories:
- reading-in-variables
tags:
- reading-in-variables
---


Use 'read' command

\`\`\`

`   #!/bin/bash`
`   # Ask the user for their name`
`   echo Hello, who am I talking to?`
`   read varname`
`   echo It\'s nice to meet you $varname`

\`\`\`

With a prompt

\`\`\`

`   #!/bin/bash`
`   # Ask the user for login details`
`   read -p 'Username: ' uservar`
`   read -sp 'Password: ' passvar`
`   echo`
`   echo Thankyou $uservar we now have your login details`

\`\`\`