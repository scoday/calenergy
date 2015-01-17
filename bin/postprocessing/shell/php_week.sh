#!/bin/bash
#
cd /srv/www/htdocs/php/week
mydir=$PWD

YESTERDAY=`date --date yesterday +%d`
PREVIOUS_DAY=`date --date today +%d`

replace() {
    for i in nuclear.php wind.php solarpv.php; do sed -i s/$PREVIOUS_DAY/$YESTERDAY/g $i; done
}

replace
