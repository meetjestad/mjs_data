cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
DATUM="`echo $IK | awk -F_ '{ print $5 }'`"
#echo "-- HIER=$HIER IK=$IK STATIONID=$STATIONID PERIODE=$PERIODE DATUM=$DATUM"

BEGINTIME="`date --date='05 apr 2019' '+%s'`"
EINDETIME="`date --date='11 apr 2019' '+%s'`"
#echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME=\"$BEGINTIME\""

DBUSER=dbuser
DBPASS=dbpass
DBASE=dbase

SQL="SELECT FROM_UNIXTIME(unixtime) AS tijd, pm25nat, pm25eu FROM rivm WHERE unixtime > '$BEGINTIME' AND unixtime < '$EINDETIME' ORDER BY unixtime ASC"

echo "-- STATIONID=$STATIONID PERIODE=$PERIODE BEGINTIME='$BEGINTIME' EINDETIME='$EINDETIME'"
echo "-- SQL='$SQL'"

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7) }'

