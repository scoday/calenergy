#!/bin/bash
#
#
# A file to test file sizes.

cd /home/scoenergy/dev/tools/bash/
mydir=$PWD

FILEMIN=144440
FILEACTUAL=$(du -b "./temp/file$i.log" | cut -f 1)
NUM=0
METAB=0

#verify_size() {
#    if "$ACTUALSIZE" -ge "$FILEMIN"; then
#      echo "i $FILE Filesize mismatch." | mail -s "File Issue." sday@mac.com < ./temp/temp.log
#    else
#      echo "File match for file $FILELIST
#    fi
#}

show_var() {

  echo $FILELIST
  for ((i=1; i<=12; i++)); do
    for j in ./temp/file$i.log ; do
     echo "$j"
     METAB=$(du -b "$j" | cut -f 1 > ./temp/log.log)
#     NUM=$(( $NUM + $METAB ))
  done
  echo "$NUM"
done 

}

show_var
