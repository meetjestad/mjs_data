echo "$0 `date`: start"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0`


SH=run_knmi_th_06m.sh
ls -l $SH
./$SH 
sleep 1
cd $HIER

for SH in run_fhum_????_06m.sh 
do
    [ `basename $SH` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH
            sleep 2
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
