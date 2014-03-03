#!/bin/sh
$YUM -y install mysql mysql-server mysql-connector-java

service mysqld restart
chkconfig mysqld on

# configure MySQL (WARNING: this is insecure!)

if ! mysqladmin -u root --password=$ROOT_DB_PASS ping 2> /dev/null | grep -q "mysqld is alive"
then
	mysqladmin -u root password $ROOT_DB_PASS
fi
echo "grant all privileges on *.* to 'root'@'%' identified by '$ROOT_DB_PASS';" | mysql -u root --password=$ROOT_DB_PASS mysql
