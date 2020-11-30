echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo STATIONID=$STATIONID PER=$PER

SH=mjs_fhum_${STATIONID}_$PER.sh
[ -x ./$SH ] && {
    ./mjs_fhum_${STATIONID}_$PER.sh > ../lst/mjs_fhum_${STATIONID}_$PER.lst
    ls -l ../lst/mjs_fhum_${STATIONID}_$PER.lst
    ls -l ../plt/mjs_fhum_${STATIONID}_$PER.plt
    ../plt/mjs_fhum_${STATIONID}_$PER.plt
    ls -l ../png/mjs_fhum_${STATIONID}_$PER.png
    rm -f ../lst/mjs_fhum_${STATIONID}_$PER.lst
}

echo "`date`   $0: gestopt"
echo ""
echo ""
