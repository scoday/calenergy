#!/bin/bash -x

mydir=$PWD

files=./temp/*.log
date=`date +%Y%m%d`
size=$( du -b ./temp/*.log ) #| cut -f 1 )

find_files() {
  echo 'Finding files in the dir.'
    ls -lah $files
  echo 'This is what we have.'
}

log_files() {
  echo $size > foo.log
  echo `cat foo.log | grep '144445' > foo2.log`
  echo $date >> foo2.log
}

mail_log() {
  mail -s "This is the result on $date" sday@mac.com < foo2.log
}

find_files
log_files
mail_log
