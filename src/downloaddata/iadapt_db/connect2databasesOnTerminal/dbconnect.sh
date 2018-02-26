#!/usr/bin/expect 

spawn ssh mattar@cfn.med.upenn.edu
# Get SQL file from server
expect "password:"
send "aequa0Ae\n"
expect "."
send "mysql -h localhost -D iadapt -u iadapt -p\n"
expect "Enter password:"
send "Eife7Oorai\n"
interact
