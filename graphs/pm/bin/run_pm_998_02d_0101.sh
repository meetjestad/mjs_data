echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
DATUM=`echo $IK | awk -F_ '{ print $5 }'`
echo STATIONID=$STATIONID PER=$PER DATUM=$DATUM

#./mjs_pm_${STATIONID}_${PER}_${DATUM}.sh > ../plt/mjs_pm_${STATIONID}_${PER}_${DATUM}.lst
cd ../plt
ls -l mjs_pm_${STATIONID}_${PER}_${DATUM}.lst

./mjs_pm_${STATIONID}_${PER}_${DATUM}.plt
ls -l mjs_pm_${STATIONID}_${PER}_${DATUM}.plt
cp -p mjs_pm_${STATIONID}_${PER}_${DATUM}.png ../vuurwerk/mjs_pm_${STATIONID}_${PER}_${DATUM}.png 

./mjs_pm_${STATIONID}_${PER}_${DATUM}_m.plt
ls -l mjs_pm_${STATIONID}_${PER}_${DATUM}_m.plt
cp -p mjs_pm_${STATIONID}_${PER}_${DATUM}_m.png ../vuurwerk/mjs_pm_${STATIONID}_${PER}_${DATUM}_m.png 
cd $HIER

echo "`date`   $0: gestopt"
echo ""
echo ""
