cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE"

case $PERIODE in
    01d) STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    04d) STARTTIME="`date --date='-4 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    02w) STARTTIME="`date --date='-2 weeks'  '+%Y-%m-%d %H:%M:%S'`" ;;
    02m) STARTTIME="`date --date='-2 months' '+%Y-%m-%d %H:%M:%S'`" ;;
    *)   STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
esac
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE STARTTIME=\"$STARTTIME\""

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env

SQL="SELECT timestamp, station_id, temperature AS temp068, humidity AS humi068, 
	    pm2_5 AS pm25_068, pm10-pm2_5 AS pm10_068, '?' AS temp176, '?' AS humi176 
     FROM sensors_measurement 
     WHERE station_id = 068 AND timestamp > '$STARTTIME' AND pm2_5 < 1000. AND pm10 < 1000. 
     ORDER BY timestamp ASC;
     SELECT timestamp, station_id, '?' AS temp068, '?' AS humi068, '?' AS pm25_068, 
            '?' AS pm10_068, temperature AS temp176, humidity AS humi176 
     FROM sensors_measurement 
     WHERE station_id = 176 AND timestamp > '$STARTTIME' ORDER BY timestamp DESC;"

echo "-- STATIONID=068,176 PERIODE=$PERIODE STARTTIME=\"$STARTTIME\""
#echo "SQL=$SQL" | sed 's/^/-- /'

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9) }'

