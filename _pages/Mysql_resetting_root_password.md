  - kill mysql
  - create a file with the following lines in it;

<!-- end list -->

    UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
    FLUSH PRIVILEGES;

  - start mysql passing in init file;

<!-- end list -->

    mysqld_safe --init-file=/tmp/mysql-init &

<b>check /var/log/mysqld.log to ensure it started and ran your file</b>

  - should be able to log in now with empty password and set a more
    secure one.
  - kill mysql once more (kill \`cat /mysql/data/mysql.pid\`) then
    restart as normal