#!/bin/bash
#
cd /srv/www/htdocs/php
mydir=$PWD

YESTERDAY=`date --date yesterday +%Y-%m-%d`
#YESTERDAY=`date --date yesterday +%Y-%m-%d`
#YESTERDAY=`date --date "2 days ago" +%Y-%m-%d`
PREVIOUS_DAY=`date --date "2 days ago" +%Y-%m-%d`

replace() {
    for i in hydro.php imports.php nuclear.php renewable.php smallhydro.php solarpv_production.php solarthermal.php thermal.php wind.php ; do sed -i s/$PREVIOUS_DAY/$YESTERDAY/g $i; done 
}

dryrun() {
    echo $PREVIOUS_DAY
    echo $YESTERDAY
}

#dryrun
replace
