echo "`date`   $0: gestart"
#echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
STATION=`echo $IK | awk -F_ '{ print $3 }'`
#PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo PER=$PER

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../plt ] && mkdir ../png


for SH in run_mjs20_${STATION}_0[1246][dwm].sh
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            #ls -l $SH | sed 's/^/    /'
            ./$SH | sed 's/^/    /'
            sleep 1
        }
    }
done

echo "`date`   $0: gestopt"
echo ""
echo ""
