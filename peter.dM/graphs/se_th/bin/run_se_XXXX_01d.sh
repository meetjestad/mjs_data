echo "$0 `date`: start"

cd `dirname $0` 
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo IK=$IK PER=$PER

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../png ] && mkdir ../png

for SH in run_se_????_${PER}.sh run_se_????_${PER}_?.sh
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH
            ./$SH | sed 's/^/    /'
	    echo ""
            sleep 2
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
