#!/bin/bash +x
# Renewableinator
# Define working dir.
cd /usr/local/scoenergy/
mydir=$PWD
#YESTERDAY=`TZ=PST+24 date +%Y%m%d`
YESTERDAY=`date --date yesterday +%Y%m%d`
#YESTERDAY=`date --date "2 days ago" +%Y%m%d`

## Isolate total production ##
isolate_renewables() {
    cat ./data/caliso/caliso-$YESTERDAY.log | sed '27,100d' ./data/caliso/caliso-$YESTERDAY.log > ./data/tmp/caliso-$YESTERDAY-renewable1.log
}

isolate_data() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable1.log | sed '1,2d' ./data/tmp/caliso-$YESTERDAY-renewable1.log > ./data/tmp/caliso-$YESTERDAY-renewable.log
}

isolate_solarpv() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f14 > ./data/caliso-solarpv/caliso-$YESTERDAY-solarpv.log
}

isolate_solarthermal() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f16 > ./data/caliso-solarthermal/caliso-$YESTERDAY-solarthermal.log
}

isolate_wind() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f12 > ./data/caliso-wind/caliso-$YESTERDAY-wind.log
}

isolate_smallhydro() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f10 > ./data/caliso-smallhydro/caliso-$YESTERDAY-smallhydro.log
}

isolate_biogas() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f8 > ./data/caliso-biogas/caliso-$YESTERDAY-biogas.log
}

isolate_biomass() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f6 > ./data/caliso-biomass/caliso-$YESTERDAY-biomass.log
}

isolate_geothermal() {
    cat ./data/tmp/caliso-$YESTERDAY-renewable.log | cut -f4 > ./data/caliso-geothermal/caliso-$YESTERDAY-geothermal.log
}

cleanup_tmp() {
    rm -f ./data/tmp/*
}

isolate_renewables
isolate_data
isolate_solarpv
isolate_solarthermal
isolate_wind
isolate_smallhydro
isolate_biogas
isolate_biomass
isolate_geothermal
cleanup_tmp
