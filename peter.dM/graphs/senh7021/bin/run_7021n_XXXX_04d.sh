echo "$0 `date`: start"
echo ""

cd `dirname $0` 
IK=`basename $0 .sh`

TYPE=`basename $0 .sh | awk -F_ '{ print $2 }'`
PER=`basename $0 .sh | awk -F_ '{ print $4 }'`

for SH in run_${TYPE}_????_${PER}.sh 
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
