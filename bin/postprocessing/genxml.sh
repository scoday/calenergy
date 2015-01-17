#!/bin/bash
#
# Blanket to capture all XML data from previous day.
cd /home/scoday/dev/scoenergy/bin/postprocessing/
mydir=$PWD
YESTERDAY=`TZ=PST+48 date +%Y%m%d`

gen_xml() {
    for i in biogas biomass geothermal hydro imports nuclear renewable smallhydro solarpv solarthermal thermal wind; do ./ruby/graph-gen.rb -f ../../data/caliso-$i/caliso-$YESTERDAY-$i.log -d 31 > ./xml/$i-$YESTERDAY.xml; done
}

copy_xml() {
    for i in biogas biomass geothermal hydro imports nuclear renewable smallhydro solarpv solarthermal thermal wind; do sudo cp ./xml/$i-$YESTERDAY.xml /srv/www/htdocs/igniter/caliso/caliso-graphs/xml/$i/; done
}

gen_xml
#copy_xml
