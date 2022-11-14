echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo "    STATIONID=$STATIONID PER=$PER"

# raw bestand wordt geschreven in de PHP:
#./mjs_pm_${STATIONID}_$PER.sh | sed 's/^/    /'
#ls -l ../lst/mjs_pm_${STATIONID}_raw_$PER.lst | sed 's/^/    /'

php ../php/mjs_pm.php $STATIONID $PER
GEVONDEN="`egrep -v '^-- ' ../lst/mjs_pm_${STATIONID}_raw_$PER.lst`"
[ -z "$GEVONDEN" ] && {
    echo "`date`   $0: niets gevonden"
} || {
    #php ../php/mjs_pm.php $STATIONID $PER
    ls -l ../lst/mjs_pm_${STATIONID}_raw_$PER.lst | sed 's/^/    /'
    ls -l ../lst/mjs_pm_${STATIONID}_cal_$PER.lst | sed 's/^/    /'
    ls -l ../lst/mjs_pm_${STATIONID}_int_$PER.lst | sed 's/^/    /'

    ls -l ../plt/mjs_pm_${STATIONID}_$PER.plt | sed 's/^/    /'
    ../plt/mjs_pm_${STATIONID}_$PER.plt
    ls -l ../png/mjs_pm_${STATIONID}_$PER.png | sed 's/^/    /'

    echo "`date`   $0: einde"
}
echo ""

