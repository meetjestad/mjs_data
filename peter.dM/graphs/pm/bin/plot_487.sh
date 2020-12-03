cd `dirname $0` 
IK=`basename $0 .sh`
STATIONID=`basename $0 .sh | awk -F_ '{ print $2 }'` 
echo "STATIONID=$STATIONID"

for SH in run_${STATIONID}_???.sh
do
    echo "SH=$SH"
    [ -x $SH ] && ./$SH
done
