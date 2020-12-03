echo "$0 `date`: gestart, loop ~ 10 s"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt

SH=../../knmi/bin/run_knmi_thdrs_04d.sh
ls -l $SH
./$SH 
sleep 1
cd $HIER

for SH in run_mjs20_????_04d.sh 
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
