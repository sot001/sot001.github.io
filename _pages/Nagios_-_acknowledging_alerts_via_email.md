1\. point an email address at your server. eg; nagios@yourserver.com

2\. add a pipe to /etc/aliases;

eg;

` nagios:     "| /usr/local/nagios/libexec/eventhandlers/emailhandler.php"`

3\. run newaliases to rebuild alias file

4\. add a symbolic link from /etc/smrsh to the script

eg

` ln -s /usr/local/nagios/libexec/eventhandlers/emailhandler.php /etc/smrsh/emailhandler.php`

emailhandler.php:

`#!/usr/bin/php`

<?php
 ###################################
 # emailhandler.php
 #
 # ensure this command has setuid on
 # chmod u+s <command.
 #
 ###################################

 function parse_subject($subject)
 {
    global $ishost, $isservice;

    $bits = explode(" ", $subject);
    if ($bits[1] == 'HOST')
        $ishost = true;
    else
        $isservice = true;

    unset($bits[0]);
    unset($bits[1]);
    if ($ishost)
    {
        return(array($bits[3]));
    } else {
        $host = $bits[2];
        unset($bits[2]);
        $service = implode(" ", $bits);
        return(array($host, $service));
    }
 }


 function parse_sender($from)
 {
    $bits = split("<|>

", $from);

`   foreach($bits as $bit)`
`   {`
`                # strip out the sender `
`       if (eregi("EMAILADDRESS.com", $bit))`
`           return $bit;`
`   }`
`}`

`// read from stdin`
`$fd = fopen("php://stdin", "r");`
`$email = "";`
`while (!feof($fd)) {`
`    $email .= fread($fd, 1024);`
`}`
`fclose($fd);`

`$log = fopen("/tmp/incomingemail.log", "a+");`
`#fputs($log, "----- ORIGINAL -----\n");`
`#fputs($log, $email);`
`#fputs($log, "----- END ORIGINAL -----\n\n\n"); `

`// handle email`
`$lines = explode("\n", $email);`

`// empty vars`
`$from = "";`
`$subject = "";`
`$headers = "";`
`$message = "";`
`$splittingheaders = true;`
`$message_complete = false;`
`$commandfile = '/usr/local/nagios/var/rw/nagios.cmd';`
`$now = time(); `

`for ($i=0; $i < count($lines); $i++) {`
`   if (eregi("Original Message", $lines[$i]))`
`       $message_complete = true;`
`   if (!$message_complete)`
`   {`
`       if ($splittingheaders) {`
`           // this is a header`
`           $headers .= $lines[$i]."\n";`

`           // look out for special headers`
`           if (preg_match("/^Subject: (.*)/", $lines[$i], $matches)) {`
`               $subject_array = parse_subject($matches[1]);`
`               $hostname = $subject_array[0];`
`           }`
`           if (preg_match("/^From: (.*)/", $lines[$i], $matches)) {`
`               $from = parse_sender($matches[1]);`
`           }`
`       } else {`
`           // not a header, but message`
`           $message .= $lines[$i]."\n";`
`       }`

`       if (trim($lines[$i])=="") {`
`           // empty line, header section has ended`
`           $splittingheaders = false;`
`       }`
`   }`
`}`
`$message .= " (ACK via email)";`
`$message = trim($message);`
`$message = ereg_replace("\r|\n", " ", $message);`

`if ($isservice)`
`{`
`   $service = $subject_array[1];`
`   $ack_cmd = '/usr/bin/printf "['.$now.'] ACKNOWLEDGE_SVC_PROBLEM;'.$hostname.';'.$service.';1;1;1;'.$from.';'.$message.'\n" > /usr/local/nagios/var/rw/nagios.cmd';`
`}`
`if ($ishost)`
`{`
`   $ack_cmd = '/usr/bin/printf "['.$now.'] ACKNOWLEDGE_HOST_PROBLEM;'.$hostname.';1;1;1;'.$from.';'.$message.'\n" > /usr/local/nagios/var/rw/nagios.cmd';`
`}`

`fputs($log, "Running: \n$ack_cmd\n\n");`
`$output = shell_exec($ack_cmd." 2>&1");`
`fputs($log, $output);`
`fclose($log);`

`?>`