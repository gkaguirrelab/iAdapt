#!/usr/bin/expect 

set serverPssword [lindex $argv 0]
set dbPssword [lindex $argv 1]
set fullsqlpath [lindex $argv 2]
set datadir [lindex $argv 3]
set host [lindex $argv 4]
set database [lindex $argv 5]
set dbusername [lindex $argv 6]
set dbpssword [lindex $argv 7]
set tablenamefile [lindex $argv 8]


spawn ssh mattar@cfn.med.upenn.edu
# Connect to server and dump sql file
expect "password:"
send "$serverPssword\n"
expect "*"
send "chmod u+rwx sqlToTxt.sh\n"
expect "*"
send "./sqlToTxt.sh $fullsqlpath $datadir $host $database $dbusername $dbpssword $tablenamefile\n"
expect "*"
send "exit\n"
expect eof
exit 0





