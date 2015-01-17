#!/bin/bash
# File to do something

cd /home/scoday/dev/tools/bash
mydir=$PWD

LIST=`ls -lah`

first() {
  echo -n "Do you want to show some files?  " 
    read -p list
      if "list"
       then echo "foo"
      else 
       echo "bar"
      fi
}

first
