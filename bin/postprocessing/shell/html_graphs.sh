#!/usr/local/bin/bash
#
# Updating web DirectoryHome
cd /usr/local/www/apache24/data/calenergy/htdocs/generation
mydir=$PWD
# Adjusted date for FreeBSD #
YESTERDAY=`date -v -1d +%m-%d-%Y`
PREVIOUS_DAY=`date -v -2d +%m-%d-%Y`

# Note the sed change, big difference between linux and bsd methods.
replace() {
    for i in hydro.html imports.html nuclear.html renewable.html smallhydro.html solarpv.html solarthermal.html thermal.html wind.html ; do sed -i "" "s/$PREVIOUS_DAY/$YESTERDAY/g" $i; done
}

replace
