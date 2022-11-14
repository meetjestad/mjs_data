echo "`date`: $0: gestart"
cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

LMN_STATION="`echo $IK | awk -F_ '{ print $3 }'`"
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
echo "-- IK=$IK LMN_STATION=$LMN_STATION PER=$PER AANTAL=$AANTAL STARTTIME=\"$STARTTIME\""

[ ! -r meetjestad_test.env ] && {
    echo "`pwd`/meetjestad_test.env not found; abort"
    exit 1
}
. ./meetjestad_test.env


# timestamp e.g. '2022-02-01 19:07:14' in UTC
SQL="SELECT timestamp, unixtime, pm25 FROM lmn_pm \
     WHERE lmn_station = '$LMN_STATION' AND pm25 < 1000. AND pm25 >= 0 \
     ORDER BY unixtime DESC LIMIT $AANTAL"

echo "-- SQL=\"$SQL\""

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }' > ../lst/lmn_pm_${LMN_STATION}_raw_${PER}.lst
ls -l ../lst/lmn_pm_${LMN_STATION}_raw_${PER}.lst | sed 's/^/    /'

echo "`date`: $0: einde"
echo ""

