#
# $Id: graphs/maint/bin/mjs_repair_XXXX_XXX.sh $
# $Author: Peter Demmer for Meetjestad! $


echo "`date`: $0: gestart"
cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATION="`echo $IK | awk -F_ '{ print $3 }'`"
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
echo "-- IK=$IK LMN_STATION=$STATION PER=$PER AANTAL=$AANTAL STARTTIME=\"$STARTTIME\""

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env


# timestamp e.g. '2022-02-01 19:07:14' in UTC
SQL="SELECT timestamp, battery, supply FROM sensors_measurement \
     WHERE station_id = '$STATION' AND timestamp > '$STARTTIME' AND battery IS NOT NULL\
     ORDER BY timestamp DESC LIMIT $AANTAL"

echo "-- SQL=\"$SQL\""

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s\n", $1, $2, $3, $4, $5) }' > ../lst/mjs_repair_${STATION}_raw_${PER}.lst

echo "`date`: $0: einde"
echo ""

