echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
MJS=../bin/mjs_fhum_${STATIONID}_$PER.sh
LST=../lst/mjs_fhum_${STATIONID}_$PER.lst
echo "    STATIONID=$STATIONID PER=$PER MJS=$MJS LST=$LST"

[ -x $MJS ] && $MJS | sed 's/^/    /'

LINES=`cat $LST | wc -l`
[ $LINES -lt 2 ] && {
    echo "    $LST is empty, no plot"
} || {
    ls -l ../plt/mjs_fhum_${STATIONID}_$PER.plt | sed 's/^/    /'
    ../plt/mjs_fhum_${STATIONID}_$PER.plt
    ls -l ../png/mjs_fhum_${STATIONID}_$PER.png | sed 's/^/    /'
}
#rm -f $LST

echo "`date`   $0: gestopt"
echo ""
echo ""
