cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
DATUM="`echo $IK | awk -F_ '{ print $5 }'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE DATUM=$DATUM"

BEGINTIME="`date --date='20 april 2019' '+%s'`"
EINDETIME="`date --date='23 april 2019' '+%s'`"
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME=\"$BEGINTIME\""

[ ! -r meetjestad_ro.env ] && {
    echo "`pwd`/meetjestad_ro.env not found; abort"
    exit 1
}
. ./meetjestad_ro.env

SQL="SELECT FROM_UNIXTIME(unixtime) AS tijd, pm25nat, pm25eu FROM rivm WHERE unixtime > '$BEGINTIME' AND unixtime < '$EINDETIME' ORDER BY unixtime ASC"

echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME='$BEGINTIME' EINDETIME='$EINDETIME'"
echo "-- SQL='$SQL'"

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }'

