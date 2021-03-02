echo "$0 `date`: start"

cd `dirname $0` 
IK=`basename $0 .sh`

for SH in run_se_????_01d.sh run_se_????_01d_?.sh
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH | sed 's/^/    /'
            sleep 2
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
