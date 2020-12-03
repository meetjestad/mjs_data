#echo sleep 20:
#sleep 20

#echo "$0 `date`: gestart; vorige liepen 15 + 5 s"
echo "$0 `date`: gestart"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo PER=$PER


for SH in run_fhum_????_${PER}.sh 
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH
            sleep 1
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
