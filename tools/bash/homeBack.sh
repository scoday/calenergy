#!/bin/bash
#
# Simple rsync script to backup: /home/scoday/ on 
# sf-fem02. Maintainer sday@mac.com

SOURCE=/home/scoday
DESTINATION=/sf-fem03/SF-FEM02/HOME/
DATE=`date +%Y%m%d`
cd /sf-fem03/SF-FEM02/HOME/
mydir=$PWD

backup_home() {
    rsync -zvr $SOURCE $DESTINATION > /var/log/$DATE-backup.log
}

email_result() {
	mail -s "$DATE SF-FEM02 Backup" sday@mac.com < /var/log/$DATE-backup.log
}

backup_home
email_result
