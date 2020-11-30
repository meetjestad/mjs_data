cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"

STARTDATE="`date -d \"-$PERIODE\" '+%Y-%m-%d'`"
ENDDATE="`date -d \"$STARTDATE +$PERIODE\" '+%Y-%m-%d'`"


cd ../php
php getmjshumi.php $STATIONID $PER
