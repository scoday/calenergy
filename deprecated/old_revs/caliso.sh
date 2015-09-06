#!/usr/local/bin/bash
# Download the ISO output and cut it up.
#
URL=http://content.caiso.com/green/renewrpt/
FILENAME=_DailyRenewablesWatch.txt
FILEDATE=`date +%Y%m%d`
NEW_DATE=$(expr 24 + 24)
YESTERDAY=`TZ=PST+48 date +%Y%m%d`
#TZ=`PST+$DAY date +%Y%m%d`
# CUT=cat solar-20121015.log | cut -f14-15 > solar-temp.log

test() {
for date_input in {1..6}
do
  i=1
  echo Today is $YESTERDAY
  echo Tomorrow is `TZ=PST+$(expr 24 + 24) date +%Y%m%d` 
done
}
 
grab_file() {
	# Download the ISO information #
	curl $URL$YESTERDAY$FILENAME > ./data/caliso-$YESTERDAY.log
} 

isolate_solar() {
	# Cut the file to output MWs for SOLAR only #
	cat ./data/caliso-$YESTERDAY.log | cut -f14-15 > ./solar/$YESTERDAY.log
}

grab_file
isolate_solar
#test