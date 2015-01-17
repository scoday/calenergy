#!/bin/bash
# Flatten and rearrange for mysql
# maintainer: scoday@gmail.com
#

DATE=`date +%Y%m%d`
SOURCE=hydro
FILE=/home/scoday/dev/scoenergy/data/caliso-hydro/caliso-$DATE-$SOURCE.log

comma() {
    printf '(%s)\n' $(printf "'%s'\n" $(</home/scoday/dev/scoenergy/data/caliso-hydro/caliso-20121201-hydro.log)|paste -s -d',') > caliso-$DATE-$SOURCE.sql
}

ins_date() {
    printf '(%s)\n' $(printf "'%s'\n" $(<./caliso-$DATE-$source.sql)|paste -s $DATE) > foo
}

comma
