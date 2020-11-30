echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../plt ] && mkdir ../lst

IK=`basename $0 .sh`
PHYS=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
DATE=`echo $IK | awk -F_ '{ print $5 }'`
SMH=`echo $IK | awk -F_ '{ print $6 }'`
echo PHYS=$PHYS PER=$PER DATE=$DATE SMH=$SMH

./balc_7021_${PHYS}_${PER}_${DATE}_$SMH.sh > ../lst/balc_7021_${PHYS}_${PER}_${DATE}_$SMH.lst
cd ../plt
ls -l ../lst/balc_7021_${PHYS}_${PER}_${DATE}_$SMH.lst
./balc_7021_${PHYS}_${PER}_${DATE}_$SMH.plt
ls -l balc_7021_${PHYS}_${PER}_${DATE}_$SMH.plt
#cp -p balc_7021_${PHYS}_${PER}_${DATE}_$SMH.png ../www86/sens7021/balc_7021_${PHYS}_${PER}_${DATE}_$SMH.png 

echo "`date`   $0: gestopt"
echo ""
echo ""
