echo "$0 `date`: start"

cd `dirname $0` 
IK=`basename $0`

for SH in run_se_????_02m.sh run_se_????_02m_?.sh
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
