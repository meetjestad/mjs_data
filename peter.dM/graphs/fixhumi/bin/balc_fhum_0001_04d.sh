cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATION_ID="`echo $IK | awk -F_ '{ printf("%04d", $3) }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"


cd ../php
php getbalchumi.php $STATION_ID $PER

echo "-- STATION_ID=$STATION_ID PER=$PER"

