#--------------------------------------------------------------------------------------------------------------------------------#
#!/bin/bash                                                                                                                      #
# Download the ISO output and cut it up.                                                                                         #
#                                                                                                                                #
#OLD_DATE=1                                                                                                                      #
#NEW_DATE=24                                                                                                                     #
#OUTPUT_DATE=$(expr $OLD_DATE + $NEW_DATE)                                                                                       #
#echo $OUTPUT_DATE                                                                                                               #
#curl http://content.caiso.com/green/renewrpt/20121130_DailyRenewablesWatch.txt > ./data/caliso/caliso-20121130.log              #
#                                                                                                                                #
#	CalISO: Daily production report and data scrub                                                                               #
#   Version: 0.1b                                                                                                                #
#   Maintainer: scoday@gmail.com                                                                                                 #
#   License: GNU                                                                                                                 #
#--------------------------------------------------------------------------------------------------------------------------------#


cd /home/scoday/dev/scoenergy/
mydir=$PWD

URL=http://content.caiso.com/green/renewrpt/
FILENAME=_DailyRenewablesWatch.txt
FILEDATE=`date +%Y%m%d`
NEW_DATE=$(expr 48 + 24)
#YESTERDAY=`TZ=PST+24 date +%Y%m%d`
DG=`date +%Y%m%d`
TG=`date +%H%M%S`

# CUT=cat solar-20121015.log | cut -f14-15 > solar-temp.log

## Collect the File From CalISO ##
grab_file() {
    # Download the ISO information #
    #curl $URL20121130$FILENAME > ./data/caliso/caliso-20121130.log
    curl http://content.caiso.com/green/renewrpt/20121130_DailyRenewablesWatch.txt > ./data/caliso/caliso-20121130.log 
    echo $mydir
}

## Isolate total production ##
isolate_total() {
  # Sed and cut the file:
  cat ./data/caliso/caliso-20121130.log | sed '1,30d' ./data/caliso/caliso-20121130.log > ./data/tmp/caliso-20121130-total.log
}

## Isolate total renewables ##
isolate_renewables() {
  cat ./data/tmp/caliso-20121130-total.log | cut -f4,13 > ./data/caliso-renewable/caliso-20121130-renewable.log
}

## Isolate total NUCLEAR ##
isolate_nuclear() {
  # Cut the file to output the awesome MWs from NUCLEAR POWER #
  cat ./data/tmp/caliso-20121130-total.log | cut -f6 > ./data/caliso-nuclear/caliso-20121130-nuclear.log
}

## Isolate total Thermal ##
isolate_thermal() {
  # Cut thermal
  cat ./data/tmp/caliso-20121130-total.log | cut -f8 > ./data/caliso-thermal/caliso-20121130-thermal.log
}

## Isolate total Imports ##
isolate_imports() {
  # Cut thermal
  cat ./data/tmp/caliso-20121130-total.log | cut -f10 > ./data/caliso-imports/caliso-20121130-imports.log
}

## Isolate total Hydro ##
isolate_hydro() {
  # Cut thermal
  cat ./data/tmp/caliso-20121130-total.log | cut -f12 > ./data/caliso-hydro/caliso-20121130-hydro.log
}

isolate_solar() {
    # Cut the file to output MWs for SOLAR only #
    cat ./data/tmp/caliso-20121130.log | cut -f14-15 > ./solar/20121130.log
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
