cd `dirname $0` 
IK=`basename $0 .sh`
TYPE=`basename $0 .sh | awk -F_ '{ print $2 }'` 
STATIONID=`basename $0 .sh | awk -F_ '{ print $3 }'` 
echo "TYPE=$TYPE STATIONID=$STATIONID"

for SH in run_${TYPE}_${STATIONID}_???.sh
do
    echo "SH=$SH"
    [ -x $SH ] && ./$SH
done
