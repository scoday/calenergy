#!/bin/bash -x
#

cd /home/scoday/dev/tools/bash
mydir=$PWD

# Variable Definitions
MINVAL=14400
TRUEVAL=14445
FILES=$( for i in ls temp/*.log; do echo $i; done )
SIZE=$( du -b ./temp/*.log | cut -f 1 )

show_files() {
  echo "Do you want to list files or get the size of files? " $INPUT
    read $INPUT
      if [ $# -eq 1 ] ; then 
        echo hi
      else echo nani?
      exit 0
      fi
}
list_files() {
  $FILES
}

show_files
