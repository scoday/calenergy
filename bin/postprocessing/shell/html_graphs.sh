#!/bin/bash
#

cd /srv/www/htdocs/generation
mydir=$PWD

YESTERDAY=`date --date yesterday +%m-%d-%Y`
#YESTERDAY=`date --date "3 days ago" +%m-%d-%Y`
PREVIOUS_DAY=`date --date "2 days ago" +%m-%d-%Y`

replace() {
    for i in hydro.html imports.html nuclear.html renewable.html smallhydro.html solarpv.html solarthermal.html thermal.html wind.html ; do sed -i s/$PREVIOUS_DAY/$YESTERDAY/g $i; done
}

replace
