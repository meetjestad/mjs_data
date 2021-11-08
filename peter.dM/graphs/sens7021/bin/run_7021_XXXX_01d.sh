echo "$0 `date`: start"

cd `dirname $0` 
IK=`basename $0`

for SH in run_7021_????_01d.sh run_7021_????_01d_?.sh
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
