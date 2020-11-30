echo "$0 `date`: start"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0`

#[ ! -d ../lst ] && mkdir ../lst
#[ ! -d ../plt ] && mkdir ../plt
#[ ! -d ../png ] && mkdir ../png


for SH in run_batt_????_06m.sh 
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
