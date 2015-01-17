#!/bin/bash
#

cd /home/scoday/scoenergy/bin/preprocessing/
mydir=$PWD

YESTERDAY=`TZ=PST+24 date +%Y%m%d`
TWODAYS=`TZ=PST+48 date +%Y%m%d`
THREEDAYS=`TZ=PST+72 date +%Y%m%d`
TODAY=`TZ=PST+24 date +%d`
SOURCES='biogas biomass geothermal hydro imports nuclear renewable smallhydro solarpv solarthermal thermal wind'
#-----Colors-----#
NUCLEAR='000000'
SMALLHYDRO='00FFFF'
HYDRO='0000FF'
RENEWABLE='D2691E'
THERMAL='DC143C'
WIND='008B8B'
SOLARTHERMAL='7FFF00'
BIOGAS='006400'
BIOMASS='8B008B'
IMPORTS='6B8E23'
SOLARPV='FFFF00'
GEOTHERM='800080'
#------------------#
 
backup_old() {
   for i in $SOURCES; do mv /home/scoday/scoenergy/bin/postprocessing/xml/$i.xml /home/scoday/scoenergy/bin/postprocessing/xml/$i-$TWODAYS.xml; done
}

create_xml() {
   for i in $SOURCES; do /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-$i/caliso-$YESTERDAY-$i.log -d $TODAY -c $COLORS -s $i > /home/scoday/scoenergy/bin/postprocessing/xml/$i.xml; done
}

create_nuclear() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-nuclear/caliso-$YESTERDAY-nuclear.log -d $TODAY -c $NUCLEAR -s nuclear > /home/scoday/scoenergy/bin/postprocessing/xml/nuclear.xml
}

create_biomass() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-biomass/caliso-$YESTERDAY-biomass.log -d $TODAY -c $BIOMASS -s biomass > /home/scoday/scoenergy/bin/postprocessing/xml/biomass.xml
}

create_biogas() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-biogas/caliso-$YESTERDAY-biogas.log -d $TODAY -c $BIOGAS -s biogas > /home/scoday/scoenergy/bin/postprocessing/xml/biogas.xml
}

create_geothermal() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-geothermal/caliso-$YESTERDAY-geothermal.log -d $TODAY -c $GEOTHERM -s geothermal > /home/scoday/scoenergy/bin/postprocessing/xml/geothermal.xml
}

create_hydro() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-hydro/caliso-$YESTERDAY-hydro.log -d $TODAY -c $HYDRO -s hydro > /home/scoday/scoenergy/bin/postprocessing/xml/hydro.xml
}

create_imports() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-imports/caliso-$YESTERDAY-imports.log -d $TODAY -c $IMPORTS -s imports > /home/scoday/scoenergy/bin/postprocessing/xml/imports.xml
}

create_renewable() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-renewable/caliso-$YESTERDAY-renewable.log -d $TODAY -c $RENEWABLE -s renewable > /home/scoday/scoenergy/bin/postprocessing/xml/renewable.xml
}

create_smallhydro() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-smallhydro/caliso-$YESTERDAY-smallhydro.log -d $TODAY -c $SMALLHYDRO -s smallhydro > /home/scoday/scoenergy/bin/postprocessing/xml/smallhydro.xml
}

create_solarpv() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-solarpv/caliso-$YESTERDAY-solarpv.log -d $TODAY -c $SOLARPV -s solarpv > /home/scoday/scoenergy/bin/postprocessing/xml/solarpv.xml
}

create_solarthermal() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-solarthermal/caliso-$YESTERDAY-solarthermal.log -d $TODAY -c $SOLARTHERMAL -s solarthermal > /home/scoday/scoenergy/bin/postprocessing/xml/solarthermal.xml
}

create_thermal() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-thermal/caliso-$YESTERDAY-thermal.log -d $TODAY -c $THERMAL -s thermal > /home/scoday/scoenergy/bin/postprocessing/xml/thermal.xml
}

create_wind() {
    /home/scoday/scoenergy/bin/postprocessing/ruby/graph-gen.rb -f /home/scoday/scoenergy/data/caliso-wind/caliso-$YESTERDAY-wind.log -d $TODAY -c $WIND -s wind > /home/scoday/scoenergy/bin/postprocessing/xml/wind.xml
}

 
transfer() {
  for i in $SOURCES; do sudo cp /home/scoday/scoenergy/bin/postprocessing/xml/$i.xml /srv/www/htdocs/igniter/caliso/caliso-graphs/xml/$i/; done
}

cleanup_old() {
    rm -f /home/scoday/scoenergy/bin/postprocessing/xml/*-$THREEDAYS.xml
}

backup_old
#create_xml
create_nuclear
create_smallhydro
create_hydro
create_renewable
create_thermal
create_wind
create_solarthermal
create_biogas
create_biomass
create_imports
create_solarpv
create_geothermal
transfer
cleanup_old
