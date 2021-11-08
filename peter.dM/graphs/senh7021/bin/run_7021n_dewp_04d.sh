echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
PHYS=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
#SMH=`echo $IK | awk -F_ '{ print $5 }'`
LST=../lst/balc_${TYPE}_${PHYS}_${PER}.lst
echo PHYS=$PHYS PER=$PER LST=$LST

./balc_${TYPE}_${PHYS}_${PER}.sh 
ls -l $LST
REGELS=`cat $LST | wc -l`
[ $REGELS = 0 ] && {
    echo "$LST is empty, skipping ..."
} || {
    ls -l ../plt/balc_${TYPE}_${PHYS}_${PER}.plt
    ../plt/balc_${TYPE}_${PHYS}_${PER}.plt
    ls -l ../png/balc_${TYPE}_${PHYS}_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
