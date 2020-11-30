echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo STATIONID=$STATIONID PER=$PER

./mjs_init_${STATIONID}_$PER.sh > ../plt/mjs_init_${STATIONID}_$PER.lst
cd ../plt
ls -l mjs_init_${STATIONID}_$PER.lst
./mjs_init_${STATIONID}_$PER.plt
ls -l mjs_init_${STATIONID}_$PER.plt
cp -p mjs_init_${STATIONID}_$PER.png ../../nodeinit/mjs_init_${STATIONID}_$PER.png 
ls -l ../../nodeinit/mjs_init_${STATIONID}_$PER.png

echo "`date`   $0: gestopt"
echo ""
echo ""
