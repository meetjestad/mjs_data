echo "gestart `date`"
BEGIN=`date '+%s'`

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%100, $2, $3, $4, $5) }' | tr abc ABC`"
[ ! -d ../log ] && mkdir ../log
UIT=../log/sensors_recent_487.$PDDC.ruw
LOG=../log/sensors_recent_487.$PDDC.log
CSV=../log/sensors_recent_487.$PDDC.csv
SQL=../log/sensors_recent_487.$PDDC.sql
echo HIER=$HIER IK=$IK PDDC=$PDDC UIT=$UIT LOG=$LOG

wget -O$UIT -o$LOG 'http://meetjestad.nl/data/sensors_recent.php?sensor=487&limit=30000'   # ~ 10 maand
ls -l $UIT $LOG

cat $UIT | egrep '<t[hr]>|</t[hr]>|<td rowspan=' | sed -f html2csv1.sed | tr -d '\n' \
    | sed 's?</tr>?\n?g' | grep -v '^$' | egrep '^ID|^<a href' | sed -f html2csv2.sed > $CSV
ls -l $CSV

sed -n '2,$p' $CSV | awk -F';' '{ printf("REPLACE INTO `measurements` (source, stationid, timestamp, temperature, humidity, lux, pm25, pm10, supply, version, latitude, longitude, fcnt) VALUES (\"recent\", %s, %c%s%c, %s, %s, %s, %s, %s, %c%s%c, %c%s%c, %s, %s, %d);\n", $1, 39, $2, 39, $3, $4, $5, $6, $7, 39, $8, 39, 39, $9, 39, $10, $11, $12) }' > $SQL

ls -l $SQL

mysql -umjs_data -Dmjs_data -p'supergeheim' < $SQL

EINDE=`date '+%s'`
DUUR=`expr $EINDE - $BEGIN` 
SDUUR=`echo $DUUR | awk '{ printf("%dm%02ds", $1/60, $1%60) }'`
echo "einde `date`,   duur $SDUUR" 
echo ""
echo ""
