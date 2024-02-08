#!/bin/bash

command_syntax="backup.sh source_dir dest_dir db_name"

if [ $# -ne 3 ];
then  printf "Command syntax: $command_syntax\n"
exit 1
fi

source_dir=$1
dest_dir=$2
db_name=$3

backup_name="$(date +%b-%d-%Y)"
temp_dir="/tmp/$backup_name"

# Make backup directory and sql sub-directory
mkdir  -p "$temp_dir/sql"

#Copy the source directory 
cp -rv $source_dir $temp_dir

# Backup the database
mysqldump -u root $db_name > "$temp_dir/sql/$db_name.sql"

# Compress the backup
tar cvzf "/tmp/$backup_name.tar.gz" "/tmp/$backup_name" 

# Delete the temporary backup folder
rm -rf "/tmp/$backup_name"

# Move the backup zip to destination directory
mv "/tmp/$backup_name.tar.gz" $dest_dir






