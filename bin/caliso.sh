#!/bin/bash -x
# Download the ISO output and cut it up.
#
#OLD_DATE=1
#NEW_DATE=24
#OUTPUT_DATE=$(expr $OLD_DATE + $NEW_DATE)
#echo $OUTPUT_DATE
cd /usr/local/scoenergy/
mydir=$PWD

URL=http://content.caiso.com/green/renewrpt/
FILENAME=_DailyRenewablesWatch.txt
FILEDATE=`date +%Y%m%d`
NEW_DATE=$(expr 48 + 24)
#YESTERDAY=`TZ=PST+24 date +%Y%m%d`
#YESTERDAY=20140510 # Use this with below grab_file for specific requests #
YESTERDAY=`date --date yesterday +%Y%m%d`
#### Use the date string below to adjust download day. ######
#YESTERDAY=`date --date "2 days ago" +%Y%m%d`
DG=`date +%Y%m%d`
TG=`date +%H%M%S`
MINIMUMSIZE=2160
ACTUALSIZE=$(du -b "./data/caliso/caliso-$YESTERDAY.log" | cut -f 1)

# CUT=cat solar-20121015.log | cut -f14-15 > solar-temp.log

## Collect the File From CalISO ##
grab_file() {
    # Download the ISO information #
    curl $URL$YESTERDAY$FILENAME > ./data/caliso/caliso-$YESTERDAY.log
	# Below used for one-offs.
	# Adjust the "YESTERDAY" variable for the date requested, then uncomment below.
    #   curl http://content.caiso.com/green/renewrpt/20121208_DailyRenewablesWatch.txt > ./data/caliso/caliso-$YESTERDAY.log 
    echo $mydir
}

verify_iso() {
#    if [ "$SIZE" -le "$ALERT" ]; then
#      echo "The file size is not consistent." | mail -s "Caliso Report Failed" sday@mac.com
#    else
#      echo "We are good to go." | mail -s "CalISO Report Passed ||$SIZE|| $DG" sday@mac.com < ./data/caliso/caliso-$YESTERDAY.log
#    fi
#    if [ -f ./data/caliso/caliso-$YESTERDAY.log ]; then
#      echo "We are good to go." | mail -s 'CALISO Exists: Continuing' sday@mac.com < ./data/caliso/caliso-$YESTERDAY.log
#    else
#      echo "Failed to find file." | mail -s 'CALISO Failed: Aborting' sday@mac.com
#    fi
# AUG 12, 2014: appending /dev/null to the mail command

    if "$ACTUALSIZE" -ge "$MINIMUMSIZE"; then
      echo "CalISO file size checks out." | mail -s "CalISO Report Passed Check |SIZE|`scho` $ACTUALSIZE|DATE|$DG|" sday@mac.com < /dev/null 
    else
      echo "CalISO file download failure." | mail -s "CalISO Download Failure |SIZE|$ACTUALSIZE|" sday@mac.com < /dev/null
    fi
}

## Isolate total production ##
isolate_total() {                                                                                                     
  # Sed and cut the file:
  cat ./data/caliso/caliso-$YESTERDAY.log | sed '1,30d' ./data/caliso/caliso-$YESTERDAY.log > ./data/tmp/caliso-$YESTERDAY-total.log
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

cleanup_tmp() {
    # Cleanup
    rm -f ./data/tmp/*
    echo "|| CALISO DATA SCRUB: $YESTERDAY || $DG || $TG || Processing Complete || Temp Files Purged ||" >> /var/log/scoenergy/caliso.log
    echo "=============================================================================================" >> /var/log/scoenergy/caliso.log
}

grab_file
verify_iso
isolate_total
isolate_nuclear
isolate_renewables
isolate_thermal
isolate_imports
isolate_hydro
cleanup_tmp
