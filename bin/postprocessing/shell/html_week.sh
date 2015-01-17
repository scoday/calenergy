#!/bin/bash
#
cd /srv/www/htdocs/generation/week
mydir=$PWD

YESTERDAY=`date --date yesterday +%d`
PREVIOUS_DAY=`date --date today +%d`

replace() {
    for i in nuclear.html wind.html solarpv.html; do sed -i s/$PREVIOUS_DAY/$YESTERDAY/g $i; done
}

replace
