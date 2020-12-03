cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
DATUM="`echo $IK | awk -F_ '{ print $5 }'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE DATUM=$DATUM"

#BEGINTIME="`date --date='31 december 2019' '+%Y-%m-%d %H:%M:%S'`"
#EINDETIME="`date --date='01 januari 2020' '+%Y-%m-%d %H:%M:%S'`"
BEGINTIME="2019-12-31 12:00:00";
EINDETIME="2020-01-01 12:00:00";
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME=\"$BEGINTIME\""

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env

SQL="SELECT timestamp, temperature, humidity, lux, pm2_5, pm10 FROM sensors_measurement \
     WHERE station_id = $STATIONID AND timestamp > '$BEGINTIME' AND timestamp < '$EINDETIME' AND pm2_5 < 1000. AND pm10 < 1000. \
     ORDER BY timestamp ASC"
SQL="SELECT ADDTIME(timestamp, '01:00:00'), temperature, humidity, lux, pm2_5, pm10 FROM sensors_measurement \
     WHERE station_id = $STATIONID AND timestamp > '$BEGINTIME' AND timestamp < '$EINDETIME' AND pm2_5 < 1000. AND pm10 < 1000. \
     ORDER BY timestamp ASC"

echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME='$BEGINTIME' EINDETIME='$EINDETIME'"
echo "-- SQL='$SQL'"

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }'

