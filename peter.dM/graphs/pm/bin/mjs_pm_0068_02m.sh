echo "`date` $0: WORDT NIET MEER GEBRUIKT"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"

case $PER in
    01d) STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`"
	    AANTAL=$(( 1 * 96 )) ;;
    04d) STARTTIME="`date --date='-4 days'   '+%Y-%m-%d %H:%M:%S'`"
	    AANTAL=$(( 4 * 96 )) ;;
    02w) STARTTIME="`date --date='-2 weeks'  '+%Y-%m-%d %H:%M:%S'`"
	    AANTAL=$(( 14 * 96 )) ;;
    02m) STARTTIME="`date --date='-2 months' '+%Y-%m-%d %H:%M:%S'`"
	    AANTAL=$(( 61 * 96 )) ;;
    *)   STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`"
	    AANTAL=$(( 1 * 96 )) ;;
esac

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env


# timestamp e.g. '2022-02-01 19:07:14' in UTC
SQL="SELECT timestamp, pm2_5, pm10 FROM sensors_measurement \
     WHERE station_id = $STATIONID AND pm2_5 < 1000 AND pm10 < 1000 AND pm2_5 >= 0 AND pm10 >= 0  \
     ORDER BY timestamp DESC LIMIT $AANTAL"

#echo "    STATIONID=$STATIONID PER=$PER STARTTIME=\"$STARTTIME\""
echo "    SQL=\"$SQL\""
    
echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }' > ../lst/mjs_pm_${STATIONID}_raw_$PER.lst
ls -l ../lst/mjs_pm_${STATIONID}_raw_$PER.lst | sed 's/^/    /'

echo "`date` $0: einde"


