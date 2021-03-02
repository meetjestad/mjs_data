echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo TYPE=$TYPE STATIONID=$STATIONID PER=$PER

#./mjs_${TYPE}_${STATIONID}_$PER.sh > ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst
./mjs_${TYPE}_${STATIONID}_$PER.sh 
GEVONDEN="`egrep -v '^-- ' ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst`"
[ -z "$GEVONDEN" ] && {
    echo "`date`   $0: niets gevonden"
} || {
    ls -l ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst
    ls -l ../plt/mjs_${TYPE}_${STATIONID}_$PER.plt
    ../plt/mjs_${TYPE}_${STATIONID}_$PER.plt
    ls -l ../png/mjs_${TYPE}_${STATIONID}_$PER.png 
    echo "`date`   $0: gestopt"
}
echo ""
echo ""
