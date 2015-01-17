#!/usr/local/bin/bash
#----------------------------#
# insert db values           #
#----------------------------#

GENERATION_TYPE=0
GENERATION_OUTPUT=0
GENERATION_HOUR=0
GENERATION_DATE=`TZ=PST+24 date +%Y%m%d`

gen_type() {
  echo 
}

production_scrub() {
  printf '(%s)\n' $(printf "'%s'\n" $(<caliso-20121201-hydro.log)|paste -s -d,)

}
production_insert() {
  

} 

production_mysql() {
  mysql -u ...
    if [ $? -eq 0 ]; then
      echo "Success"
    else
      echo "Failure"
    fi
}

#INSERT INTO production_hydro 
#  ( prod_date, prod_hour, prod_output ) 
#VALUES  
#  ('20121101', '3', '1019'),
#  ('20121101', '4', '1032'),
#  ('20121101', '5', '1108')
#
production_insert
production_mysql
