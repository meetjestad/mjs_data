echo "$0 `date`: start"

cd `dirname $0` 
IK=`basename $0`

for SH in run_perf_????_06y.sh run_perf_????_06y_?.sh
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
