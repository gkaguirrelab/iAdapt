#!/usr/bin/expect 

# Connect to database
spawn ssh mattar@cfn.med.upenn.edu

# Connect to sql database
set sshPssword [lindex $argv 0]
set dbPssword [lindex $argv 1]
expect "password:"
send "$sshPssword\n";
send "mysql -h localhost -D iadapt -u iadapt -p\n";
expect "password:"
send "$dbPssword\n"

# Read in commands to be executed line by line
set f [open "commands.txt"]
set commands [split [read $f] "\n"]
close $f

# Execute commands line by line
foreach cmd $commands {
        send "$cmd\n"
    }
# Quit database and exit ssh
#send "quit;\n"
#send "exit\n"
interact
