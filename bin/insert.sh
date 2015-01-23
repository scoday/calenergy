#!/usr/local/bin/bash
# Renewableinator
# Define working dir.
cd /usr/local/calenergy/
mydir=$PWD
# Update to the YESTERDAY variable to suit FreeBSD style date #
# FORMAT: date -v -1d +%Y%m%d with -1d being number of days ahead or + for behind #
YESTERDAY=`date -v -1d +%Y%m%d`
DAY=`date -v -1d +%Y%m%d`
DG=`date +%Y%m%d`
TG=`date +%H%M%S`
COUNT=`cat ./data/tmp/sql/count.txt`

## Isolate total production ##
insert_biogas() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-biogas/caliso-$YESTERDAY-biogas.log -d $DAY -s biogas > ./data/tmp/sql/biogas.sql && mysql -hsf-jl04 -ucalenergy -pcalenergy -Dscoenergy < ./data/tmp/sql/biogas.sql
} 

insert_biomass() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-biomass/caliso-$YESTERDAY-biomass.log -d $DAY -s biomass > ./data/tmp/sql/biomass.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/biomass.sql
}

insert_wind() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-wind/caliso-$YESTERDAY-wind.log -d $DAY -s wind > ./data/tmp/sql/wind.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/wind.sql
}

insert_solarpv() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-solarpv/caliso-$YESTERDAY-solarpv.log -d $DAY -s solarpv > ./data/tmp/sql/solarpv.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/solarpv.sql
}

insert_solarthermal() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-solarthermal/caliso-$YESTERDAY-solarthermal.log -d $DAY -s solarthermal > ./data/tmp/sql/solarthermal.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/solarthermal.sql
}

insert_geothermal() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-geothermal/caliso-$YESTERDAY-geothermal.log -d $DAY -s geothermal > ./data/tmp/sql/geothermal.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/geothermal.sql
}

insert_hydro() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-hydro/caliso-$YESTERDAY-hydro.log -d $DAY -s hydro > ./data/tmp/sql/hydro.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/hydro.sql
}

insert_imports() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-imports/caliso-$YESTERDAY-imports.log -d $DAY -s imports > ./data/tmp/sql/imports.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/imports.sql
}

insert_nuclear() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-nuclear/caliso-$YESTERDAY-nuclear.log -d $DAY -s nuclear > ./data/tmp/sql/nuclear.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/nuclear.sql
}

insert_renewable() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-renewable/caliso-$YESTERDAY-renewable.log -d $DAY -s renewable > ./data/tmp/sql/renewable.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/renewable.sql
}

insert_smallhydro() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-smallhydro/caliso-$YESTERDAY-smallhydro.log -d $DAY -s smallhydro > ./data/tmp/sql/smallhydro.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/smallhydro.sql
}

insert_thermal() {
    ./bin/preprocessing/ruby/scoday.rb -f /usr/local/calenergy/data/caliso-thermal/caliso-$YESTERDAY-thermal.log -d $DAY -s thermal > ./data/tmp/sql/thermal.sql && mysql -hsf-jl04 -ucalenergy  -pcalenergy -Dscoenergy < ./data/tmp/sql/thermal.sql
}

email_results() {
    # echo "This is the message body" | mutt -a file.to.attach -s "subject of message" recipient@domain.com
    cat ./data/tmp/sql/*.sql >> ./data/tmp/sql/sql_inserts.txt && cat ./data/tmp/sql/sql_inserts.txt | wc -l >> ./data/tmp/sql/count.sql && echo "$YESTERDAY SQL Inserts. Review and then discard of this message." |  mail -s "$YESTERDAY SQL Inserts: (Review)" sday@mac.com < ./data/caliso/caliso-$YESTERDAY.log #mutt -a ./data/tmp/sql/sql_inserts.txt -s "$YESTERDAY SQL Inserts: (Review)" sday@mac.com
}

calenergy_logging() {
    # Put logs
    echo "|| DATABASE INSERT: $YESTERDAY || $DG || $TG || Processing Complete || DB Input $COUNT || Database Temp Files Being Purged ||" >> /var/log/calenergy/caliso.log
    echo "================================================================================================================================" >> /var/log/calenergy/caliso.log
}

cleanup_tmp() {
    rm -f ./data/tmp/sql/*
}

insert_biogas
insert_biomass
insert_wind
insert_solarpv
insert_solarthermal
insert_geothermal
insert_hydro
insert_imports
insert_nuclear
insert_renewable
insert_smallhydro
insert_thermal
email_results
calenergy_logging
#cleanup_tmp
