echo "$0 `date`: start"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
#P1="`echo $IK | awk -F_ '{ print $1 }'`"
#P2="`echo $IK | awk -F_ '{ print $2 }'`"
#P3="`echo $IK | awk -F_ '{ print $3 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"
#echo IK=$IK PER=$PER

[ ! -d ../plt ] && mkdir ../plt

#SH=run_knmi_regen_${PER}.sh
#ls -l $SH
#./$SH 
#sleep 1
#cd $HIER

for SH in run_boom_[0-9][0-9][0-9][0-9]_${PER}.sh 
do
    [ `basename $SH .sh` != $IK ] && {
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
