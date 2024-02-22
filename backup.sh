#!/bin/bash

command_syntax="backup.sh source_dir dest_dir db_name"

if [ $# -ne 3 ]; then
  printf "Command syntax: $command_syntax\n"
  exit 1
fi

source_dir=$1
dest_dir=$2
db_name=$3

backup_name="$(date +%b-%d-%Y)"
temp_dir="/tmp/$backup_name"

# Make backup directory and sql sub-directory
printf "Creating backup directory...\n";
mkdir -p "$temp_dir/sql" || { printf "Failed to create temporary directory: $temp_dir\n"; exit 1; }

# Copy the source directory
printf "Copying the source directory...\n";
cp -rv "$source_dir" "$temp_dir" || { printf "Failed to copy source directory: $source_dir\n"; exit 1; }

# Backup the database
printf "Backing up database...\n";
mysqldump -u root "$db_name" > "$temp_dir/sql/$db_name.sql" || { printf "Failed to create database backup: $db_name\n"; exit 1; }

# Compress the backup
printf "Compressing the backup...\n";
tar cvzf "/tmp/$backup_name.tar.gz" "/tmp/$backup_name" || { printf "Failed to create compressed backup: $backup_name.tar.gz\n"; exit 1; }

# Delete the temporary backup folder
printf "Deleting the temporary backup folder...\n";
rm -rf "$temp_dir" || { printf "Failed to delete temporary directory: $temp_dir\n"; exit 1; }

# Move the backup zip to destination directory
printf "Moving the backup archive to destination directory...\n";
mv "/tmp/$backup_name.tar.gz" "$dest_dir" || { printf "Failed to move backup file: $backup_name.tar.gz\n"; exit 1; }

echo "Backup completed successfully!"
