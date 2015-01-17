#!/bin/bash
#
#----------------
cd /home/scoday/dev/scoenergy/bin/postprocessing/shell/
mydir=$PWD
YESTERDAY=`TZ=PST+48 date +%Y%m%d`
YTITLE=`TZ=PST+48 date +%m/%d/%Y`

build_header() {
    echo "<graph caption='California Nuclear vs. SolarPV / Wind / Renewable (Total) $YTITLE' xAxisName='Hour' yAxisName='Output (MW)' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='0' decimalPrecision='0' showvalues='0' animation='1' numdivlines='3' numVdivlines='0' yaxisminvalue='0' yaxismaxvalue='3800' lineThickness='3' rotateNames='1'>
" > $YESTERDAY-chart.xml
}

build_guts() {
    awk  'BEGIN{print "<data>"}
    {cou++;for(i=1;i<=NF;i++)
    { if(i==1) { print "< Filed"cou" name=\"" $1 "\">" }
      else {print "<Otherfield name=\"" $i "\"><\Otherfield>" }
    } {print "<\/Filed"cou">" }
    } END{print "<\/data>"}' flatfile
}

build_biomass() {
    sed '1i\<dataset seriesname="Biomass" color="D64646" showvalue="1">' ./caliso-$YESTERDAY-biomass.log > ./biomass1.xml
    sed '$a\</dataset>' ./biomass1.xml > ./biomass.xml
}
build_header
build_biomass
