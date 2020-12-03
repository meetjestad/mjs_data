cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
STARTDATE="2019-08-17" 
ENDDATE="`date -d \"$STARTDATE +2 months\" '+%Y-%m-%d'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE"
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE STARTDATE=\"$STARTTIME\" ENDDATE=\"$ENDDATE\""

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env

SQL="SELECT timestamp, temperature, humidity, lux, pm2_5, pm10-pm2_5 FROM sensors_measurement WHERE station_id = $STATIONID AND timestamp > '$STARTDATE 00:00:00' AND timestamp < '$ENDDATE 00:00:00' AND pm2_5 < 1000. AND pm10 < 1000. ORDER BY timestamp ASC"

echo "-- STATIONID=$STATIONID PERIODE=$PERIODE"
echo "-- SQL=\"$SQL\""

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }'
