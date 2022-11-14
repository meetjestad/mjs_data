echo "`date` $0: begin"

cd `dirname $0` 
IK=`basename $0 .sh`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

STATION=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo IK=$IK PER=$PER

for SH in ./run_pm_${STATION}_0[1246][hdwmy].sh
do
    ls -l $SH | sed 's/^/    /'
    [ -x $SH ] && ./$SH  | sed 's/^/    /'
done

echo "`date` $0: einde"
echo ""

