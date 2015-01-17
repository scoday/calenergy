#!/usr/local/bin/bash
# Download the ISO output and cut it up.
#
#OLD_DATE=1
#NEW_DATE=24
#OUTPUT_DATE=$(expr $OLD_DATE + $NEW_DATE)
#echo $OUTPUT_DATE
cd /home/scoday/dev/scoenergy/
mydir=$PWD

URL=http://content.caiso.com/green/renewrpt/
FILENAME=_DailyRenewablesWatch.txt
FILEDATE=`date +%Y%m%d`
NEW_DATE=$(expr 48 + 24)
YESTERDAY=`TZ=PST+727272727272727272727272727272727272727272727272727272727272727272727272727272727272727272727272
DG=`date +%Y%m%d`
TG=`date +%H%M%S`

# CUT=cat solar-20121015.log | cut -f14-15 > solar-temp.log

## Collect the File From CalISO ##
grab_file() {
    # Download the ISO information #
    curl $URL$YESTERDAY$FILENAME > ./data/caliso-$YESTERDAY.log
    echo $mydir
}

## Isolate total production ##
isolate_total() {
  # Sed and cut the file:
  cat ./data/caliso-$YESTERDAY.log | sed '1,30d' ./data/caliso-$YESTERDAY.log > ./data/tmp/caliso-$YESTERDAY-total.log
}

## Isolate total renewables ##
isolate_renewables() {
  cat ./data/tmp/caliso-$YESTERDAY-total.log | cut -f4,13 > ./data/caliso-renewable/caliso-$YESTERDAY-renewable.log
}

## Isolate total NUCLEAR ##
isolate_nuclear() {
  # Cut the file to output the awesome MWs from NUCLEAR POWER #
  cat ./data/tmp/caliso-$YESTERDAY-total.log | cut -f6 > ./data/caliso-nuclear/caliso-$YESTERDAY-nuclear.log
}

## Isolate total Thermal ##
isolate_thermal() {
  # Cut thermal
  cat ./data/tmp/caliso-$YESTERDAY-total.log | cut -f8 > ./data/caliso-thermal/caliso-$YESTERDAY-thermal.log
}

## Isolate total Imports ##
isolate_imports() {
  # Cut thermal
  cat ./data/tmp/caliso-$YESTERDAY-total.log | cut -f10 > ./data/caliso-imports/caliso-$YESTERDAY-imports.log
}

## Isolate total Hydro ##
isolate_hydro() {
  # Cut thermal
  cat ./data/tmp/caliso-$YESTERDAY-total.log | cut -f12 > ./data/caliso-hydro/caliso-$YESTERDAY-hydro.log
}

isolate_solar() {
    # Cut the file to output MWs for SOLAR only #
    cat ./data/tmp/caliso-$YESTERDAY.log | cut -f14-15 > ./solar/$YESTERDAY.log
}

show_result() {
    ls -lhrt ./data/caliso-*/
}

cleanup_tmp() {
    # Cleanup
    rm -f ./data/tmp/*
    echo "|| $DG || $TG || Processing Complete || DB Input || Temp Files Purged ||" >> /var/log/scoenergy/caliso.log

}

grab_file
isolate_total
isolate_nuclear
isolate_renewables
isolate_thermal
isolate_imports
isolate_hydro
show_result
cleanup_tmp
#isolate_solar
