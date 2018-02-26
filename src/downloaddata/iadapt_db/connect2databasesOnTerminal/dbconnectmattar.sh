#!/usr/bin/expect 

spawn ssh mattar@cfn.med.upenn.edu
# Get SQL file from server
expect "password:"
send "aequa0Ae\n"
expect "."
send "mysql -h localhost -u mattar -p\n"
expect "Enter password:"
send "aP5eiBo6\n"
interact
