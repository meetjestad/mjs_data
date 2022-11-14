echo "`date`   $0 gestart"
#echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
TYPE="`echo $IK | awk -F_ '{ print $2 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"
#echo "HIER=$HIER IK=$IK TYPE=$TYPE PER=$PER"

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png


for SH in run_${TYPE}_????_${PER}.sh 
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            #ls -l $SH
            ./$SH | sed 's/^/    /'
            sleep 2
        }
    }
done

echo "`date`   $0: gestopt"

echo ""
echo ""
