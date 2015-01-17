#!/bin/bash -e
#
#
# PRIMARY VARIABLES #
cd /home/scoday/scoenergy/bin/preprocessing/
mydir=$PWD

YESTERDAY=`TZ=PST+24 date +%Y%m%d`
TWODAYS=`TZ=PST+48 date +%Y%m%d`
TODAY=`TZ=PST+24 date +%d`
POSTPRO='/home/scoday/scoenergy/bin/postprocessing'
SOURCES='biogas biomass geothermal hydro imports nuclear renewable smallhydro solarpv solarthermal thermal wind'
RENEWABLE='biogas biomass geothermal hydro renewable smallhydro solarpv solarthermal wind'
BASELOAD='nuclear thermal imports'
SUBSIDIZED='solarpv solarthermal wind'
NUCLEARRENEW='nuclear solarpv solarthermal wind'

combined() {
    for i in $SOURCES; do cat $POSTPRO/xml/$i.xml >> $POSTPRO/xml/ci1.xml; done
    cat $POSTPRO/xml/ci1.xml | sed '54,81d;108,135d;162,189d;216,243d;270,297d;324,351d;378,405d;432,459d;486,513d;540,567d;594,621d' > $POSTPRO/xml/caliso2.xml
    for i in $ALLCOLORS; do cat $POSTPRO/xml/caliso2.xml | sed -i.bak s/D64646/$i/g; done 
}

renewable_only() {
    for i in $RENEWABLE; do cat $POSTPRO/xml/$i.xml >> $POSTPRO/xml/renew.xml; done
    cat $POSTPRO/xml/renew.xml | sed '54,81d;108,135d;162,189d;216,243d;270,297d;324,351d;378,405d;432,459d' > $POSTPRO/xml/caliso5.xml
}

nuclear_renew() {
    for i in $NUCLEARRENEW; do cat $POSTPRO/xml/$i.xml >> $POSTPRO/xml/nrenew.xml; done
    cat $POSTPRO/xml/nrenew.xml | sed '54,81d;108,135d;162,189d' > $POSTPRO/xml/caliso3.xml
}

baseload() {
    for i in $BASELOAD; do cat $POSTPRO/xml/$i.xml >> $POSTPRO/xml/baseload.xml; done
    cat $POSTPRO/xml/baseload.xml | sed '54,81d;108,135d' > $POSTPRO/xml/caliso4.xml
}

subsidized() {
    for i in $SUBSIDIZED; do cat $POSTPRO/xml/$i.xml >> $POSTPRO/xml/subs.xml; done
    cat $POSTPRO/xml/subs.xml | sed '54,81d;108,135d' > $POSTPRO/xml/caliso6.xml
}

cleanup_ship() {
    rm -f $POSTPRO/xml/ci1.xml $POSTPRO/xml/renew.xml $POSTPRO/xml/nrenew.xml $POSTPRO/xml/baseload.xml $POSTPRO/xml/subs.xml
}

transfer() {
    sudo cp $POSTPRO/xml/caliso*.xml /srv/www/htdocs/igniter/caliso/caliso-graphs/xml/summaries/
}

    


combined
renewable_only
nuclear_renew
baseload
subsidized
cleanup_ship
transfer
