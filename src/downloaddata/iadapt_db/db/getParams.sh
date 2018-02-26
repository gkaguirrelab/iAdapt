#!/usr/bin/expect 

set sftpPssword [lindex $argv 0]
set paramsDir [lindex $argv 1]
set localDir [lindex $argv 2]


spawn sftp mattar@cfn.med.upenn.edu
# Get SQL file from server
expect "password:"
send "$sftpPssword\n"
expect ">"
send "get -r $paramsDir  $localDir\n"
expect ".*"
send "exit\n"
expect eof
exit 0

