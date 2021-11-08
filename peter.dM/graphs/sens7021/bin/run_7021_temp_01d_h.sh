echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../plt ] && mkdir ../plt

IK=`basename $0 .sh`
PHYS=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
SMH=`echo $IK | awk -F_ '{ print $5 }'`
LST=../lst/balc_7021_${PHYS}_${PER}_$SMH.lst
echo PHYS=$PHYS PER=$PER SMH=$SMH LST=$LST

./balc_7021_${PHYS}_${PER}_$SMH.sh > $LST
REGELS=`grep -v '^-- '  $LST | wc -l`
[ $REGELS = 0 ] && {
    echo "$LST is empty, skipping ..."
} || {
    cd ../plt
    ls -l ../lst/balc_7021_${PHYS}_${PER}_$SMH.lst
    ./balc_7021_${PHYS}_${PER}_$SMH.plt
    ls -l balc_7021_${PHYS}_${PER}_$SMH.plt
}

echo "`date`   $0: gestopt"
echo ""
echo ""
