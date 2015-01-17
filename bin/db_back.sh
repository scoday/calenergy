#!/bin/bash
#
DATE=`date --date yesterday +%Y%m%d`

db_dump() {
    mysqldump scoenergy > $DATE-scoenergy.sql
}

db_xfer() {
    scp $DATE-scoenergy.sql sf-fem01:/DATA/scoenergy-db/
}

application_back() {
    rsync -avz -e ssh --progress /usr/local/scoenergy/ sf-fem01:/DATA/scoenergy-app/
}

w3_back() {
    rsync -avz -e ssh --progress /srv/www/htdocs/ sf-fem01:/DATA/scoenergy-w3/
}

db_dump
db_xfer
application_back
w3_back
