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
echo PHYS=$PHYS PER=$PER

./balc_${TYPE}_${PHYS}_${PER}.sh #> ../lst/balc_${TYPE}_${PHYS}_${PER}.lst
#cd ../plt
ls -l ../lst/balc_${TYPE}_${PHYS}_${PER}.lst
ls -l ../plt/balc_${TYPE}_${PHYS}_${PER}.plt
../plt/balc_${TYPE}_${PHYS}_${PER}.plt
ls -l ../png/balc_${TYPE}_${PHYS}_${PER}.png

echo "`date`   $0: gestopt"
echo ""
echo ""
