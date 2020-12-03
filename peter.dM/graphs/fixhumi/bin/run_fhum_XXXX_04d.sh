#sleep 15   # vorige scripts lopen 5 + 10 s

#echo "$0 `date`: gestart, loopt ongeveer 15 s"
echo "$0 `date`: gestart"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

SH=run_knmi_th_04d.sh
ls -l $SH
./$SH 
sleep 1
cd $HIER

for SH in run_fhum_????_04d.sh 
do
    [ `basename $SH` != $IK ] && {
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
