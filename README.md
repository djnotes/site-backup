# site-backup: A simple site-backup solution

Run the script to create a backup in the specified directory

Can be used in combination with a cron job to automate server backups

# Important: The command needs to be run as root

# How to Run with Cron
- Install the script somewhere like /usr/local/bin:
```
sudo install ./backup.sh /usr/local/bin/backup
```
- Create a cronjob that will execute the script for every interval you want to back up a specific folder.
```
crontab -e
# TO BE COMPLETED

```