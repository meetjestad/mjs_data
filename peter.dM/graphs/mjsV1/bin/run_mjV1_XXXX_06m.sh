echo "`date`   $0: gestart"
#echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo PER=$PER

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../plt ] && mkdir ../png


#for SH in run_mjsV1_????_04d.sh run_mjsV1_????_?_04d.sh
for SH in run_mjsV1_????_${PER}.sh
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            #ls -l $SH | sed 's/^/    /'
            ./$SH | sed 's/^/    /'
            sleep 2
        }
    }
done

echo "`date`   $0: gestopt"

echo ""
echo ""
echo ""
echo ""
