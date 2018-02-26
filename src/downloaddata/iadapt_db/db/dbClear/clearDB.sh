#!/usr/bin/expect 


set serverPssword [lindex $argv 0]
set dbPssword [lindex $argv 1]
set host [lindex $argv 2]
set database [lindex $argv 3]
set username [lindex $argv 4]
set tablenamesfile [lindex $argv 5]


set f [open "$tablenamesfile"]
set tables [split [read $f] "\n"]
close $f

spawn ssh mattar@cfn.med.upenn.edu
# Connect to server and dump sql file
expect "password:"
send "$serverPssword\n"
expect ".*"
send "mysql -h $host -D $database -u $username -p\n"
expect "Enter password:"
send "$dbPssword\n"

foreach t $tables {
		#Check if a blank line was read 
		if { 0 ==[string equal $t ""]} {
        send "truncate table $t;\n"
        expect ".*"
        }
    }

send "quit;\n"
expect ">"
send "exit\n"
expect eof
exit 0






