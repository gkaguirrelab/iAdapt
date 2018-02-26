#!/bin/bash 

fullsqlpath=$1
datadir=$2
host=$3
database=$4
username=$5
pssword=$6
tablenamefile=$7

# Remove and recreate data directory to clear it
rm -r $datadir
mkdir $datadir

# Get names of tables in database
query=$($fullsqlpath -h $host -D $database -u $username -p$pssword -e "SELECT table_name FROM information_schema.tables WHERE table_type = 'base table' AND table_schema = '$database'")
tables=( $( for i in $query ; do echo $i ; done ) )

# Write the contents of each table to it's respective .txt file
# Ignore the first element, as this is the name of the table
# containing the names of the tables in our database 
length=${#tables[@]}
for (( i=1 ; i<length ; i++ )) do
	 $fullsqlpath -h $host -D $database -u $username -p$pssword -e "SELECT * from ${tables[$i]}" >  $datadir/${tables[$i]}.txt 
done

# Output table names to a text file, to be used locally
for (( i=1 ; i<length ; i++ )) do
echo ${tables[$i]}
done > $datadir/$tablenamefile




