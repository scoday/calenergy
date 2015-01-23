#!/usr/local/bin/bash
#
cd /usr/local/www/apache24/data/calenergy/htdocs/php
mydir=$PWD

YESTERDAY=`date -v -1d +%Y-%m-%d`
PREVIOUS_DAY=`date -v -1d +%Y-%m-%d`

replace() {
    for i in hydro.php imports.php nuclear.php renewable.php smallhydro.php solarpv_production.php solarthermal.php thermal.php wind.php ; do sed -i "" "s/$PREVIOUS_DAY/$YESTERDAY/g" $i; done 
}

dryrun() {
    echo $PREVIOUS_DAY
    echo $YESTERDAY
}

#dryrun
replace
