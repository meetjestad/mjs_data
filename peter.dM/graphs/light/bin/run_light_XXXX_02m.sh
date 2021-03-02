cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
TYPE="`echo $IK | awk -F_ '{ print $2 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"
echo HIER=$HIER TYPE=$TYPE PER=$PER

for SH in ./run_${TYPE}_[0-9][0-9][0-9][0-9]_${PER}.sh
do
    [ -x $SH ] && ./$SH
done
