cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

TYPE="`echo $IK | awk -F_ '{ print $2 }'`"
STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE"

case $PERIODE in
    01d) STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    04d) STARTTIME="`date --date='-4 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    02w) STARTTIME="`date --date='-2 weeks'  '+%Y-%m-%d %H:%M:%S'`" ;;
    02m) STARTTIME="`date --date='-2 months' '+%Y-%m-%d %H:%M:%S'`" ;;
    06m) STARTTIME="`date --date='-6 months' '+%Y-%m-%d %H:%M:%S'`" ;;
    *)   STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
esac
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE STARTTIME=\"$STARTTIME\""

#[ ! -r meetjestad_ro.env ] && {
    #echo "`pwd`/meetjestad_ro.env not found; abort"
    #exit 1
#}
#. ./meetjestad_ro.env


#SQL="SELECT timestamp, lux FROM sensors_measurement \
     #WHERE station_id = $STATIONID AND timestamp > '$STARTTIME' \
     #ORDER BY timestamp ASC"

#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE STARTTIME=\"$STARTTIME\" SQL=\"$SQL\""

#echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s\n", $1, $2, $3) }'

php ../php/mjs_${TYPE}.php $STATIONID $PERIODE

