echo "$0 `date`: gestart, loop ~ 10 s"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0`

[ ! -d ../plt ] && mkdir ../plt

SH=run_knmi_regen_04d.sh
ls -l $SH
./$SH 
sleep 1
cd $HIER

for SH in run_bodem_????_04d.sh 
do
    [ `basename $SH` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH | sed 's/^/    /'
            sleep 1
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
