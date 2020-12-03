echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo STATIONID=$STATIONID PER=$PER

./mjs_pm_${STATIONID}_$PER.sh > ../plt/mjs_pm_${STATIONID}_$PER.lst
cd ../plt
GEVONDEN="`egrep -v '^-- ' mjs_pm_${STATIONID}_$PER.lst`"
GEVONDEN=ja
[ -z "$GEVONDEN" ] && {
    echo "`date`   $0: niets gevonden"
} || {
    ls -l mjs_pm_${STATIONID}_$PER.lst
    ./mjs_pm_${STATIONID}_$PER.plt
    ls -l mjs_pm_${STATIONID}_$PER.plt
    cp -p mjs_pm_${STATIONID}_$PER.png ../node/$STATIONID/mjs_pm_${STATIONID}_$PER.png 
    echo "`date`   $0: gestopt"
}
echo ""
echo ""
