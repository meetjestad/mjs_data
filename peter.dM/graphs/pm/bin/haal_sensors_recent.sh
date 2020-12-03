# $Id:$
# homeio4.demmer.xs4all.nl:~mjs_data/bin/haal_sensors_recent.sh
# author: Peter Demmer

echo "gestart `date`"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%10, $2, $3, $4, $5) }' | tr abc ABC`"
[ ! -d ../log ] && mkdir ../log
UIT=../log/sensors_recent.$PDDC.ruw
LOG=../log/sensors_recent.$PDDC.log
CSV=../log/sensors_recent.$PDDC.csv
SQL=../log/sensors_recent.$PDDC.sql
echo HIER=$HIER IK=$IK PDDC=$PDDC UIT=$UIT LOG=$LOG

# fetch the last 400 measurements from meetjestad.nl:
wget -O$UIT -o$LOG http://meetjestad.nl/data/sensors_recent.php?limit=400   # ~ 30 min
ls -l $UIT $LOG

# parse the raw html data into columns:
cat $UIT | egrep '<t[hr]>|</t[hr]>|<td rowspan=' | sed -f html2csv1.sed | tr -d '\n' \
    | sed 's?</tr>?\n?g' | grep -v '^$' | egrep '^ID|^<a href' | sed -f html2csv2.sed > $CSV
ls -l $CSV

# format the data into a SQL query:
sed -n '2,$p' $CSV | awk -F';' '{ printf("REPLACE INTO `measurements` (source, stationid, timestamp, temperature, humidity, lux, pm25, pm10, supply, version, latitude, longitude, fcnt) VALUES (\"recent\", %s, %c%s%c, %s, %s, %s, %s, %s, %c%s%c, %c%s%c, %s, %s, %d);\n", $1, 39, $2, 39, $3, $4, $5, $6, $7, 39, $8, 39, 39, $9, 39, $10, $11, $12) }' > $SQL

ls -l $SQL

# store the data in the database:
MJS_DATA_PASS='dbpass'
mysql -udbuser -Ddbase -p$MJS_DATA_PASS < $SQL
echo "invoer gereed: `date`"

# add the unixtime (seconds since epoch) to new rows in the database:
mysql -umjs_data -Dmjs_data -p$MJS_DATA_PASS < update_unixtime_recent.sql

echo "einde `date`" 
echo ""
echo ""
