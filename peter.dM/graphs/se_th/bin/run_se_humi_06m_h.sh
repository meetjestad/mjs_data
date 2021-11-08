echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
#[ ! -d ../plt ] && mkdir ../plt

IK=`basename $0 .sh`
PHYS=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
SMH=`echo $IK | awk -F_ '{ print $5 }'`
LST=../lst/balc_se_${PHYS}_${PER}_$SMH.lst
PLT=../plt/balc_se_${PHYS}_${PER}_$SMH.plt
PNG=../plt/balc_se_${PHYS}_${PER}_$SMH.png
echo PHYS=$PHYS PER=$PER SMH=$SMH LST=$LST PLT=$PLT PNG=$PNG

./balc_se_${PHYS}_${PER}_$SMH.sh > $LST
ls -l $LST
REGELS=`grep -v '^-- ' $LST | wc -l`
[ $REGELS = 0 ] && {
    echo "$LST is empty: skipping ..."
} || {
    ls -l $PLT
    $PLT
    ls -l $PNG
}

echo "`date`   $0: gestopt"
echo ""
