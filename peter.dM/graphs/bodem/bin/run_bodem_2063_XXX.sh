echo "`date`   $0: start"
#echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
STATION=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo STATION=$STATION PER=$PER


for SH in run_bodem_${STATION}_0[1246][dwmy].sh 
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH | sed 's/^/    /'
            sleep 1
        }
    }
done

echo "`date`   $0: einde"

echo ""
echo ""
echo ""
echo ""
