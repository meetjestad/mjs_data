# $Id:$
# author: Peter dM

echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
SML=`echo $IK | awk -F_ '{ print $5 }'`
echo STATIONID=$STATIONID PER=$PER SML=$SML

./mjs_pm_${STATIONID}_${PER}_$SML.sh > ../plt/mjs_pm_${STATIONID}_${PER}_$SML.lst
cd ../plt
GEVONDEN="`egrep -v '^-- ' mjs_pm_${STATIONID}_${PER}_$SML.lst`"
[ -z "$GEVONDEN" ] && {
    echo "`date`   $0: niets gevonden"
} || {
    ls -l mjs_pm_${STATIONID}_${PER}_$SML.lst
    ./mjs_pm_${STATIONID}_${PER}_$SML.plt
    ls -l mjs_pm_${STATIONID}_${PER}_$SML.plt
    cp -p mjs_pm_${STATIONID}_${PER}_$SML.png ../node/$STATIONID/mjs_pm_${STATIONID}_${PER}_$SML.png 
    echo "`date`   $0: gestopt"
}
echo ""
echo ""
