echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
STATIONID=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
BLST=../../batt/lst/mjs_batt_2008_sb_${PER}.lst
echo TYPE=$TYPE STATIONID=$STATIONID PER=$PER BLST=$BLST

#./mjs_${TYPE}_${STATIONID}_$PER.sh > ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst
./mjs_${TYPE}_${STATIONID}_$PER.sh 
STOP=""
VIND="`egrep -v '^-- ' ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst`"
[ -z "$VIND" ] && {
    echo "`date`   $0: niets gevonden: geen grafiek"
    STOP=ja
} || {
    BVIND=`cat $BLST | wc -l`
    [ $BVIND -lt 2 ] && {
        echo "`date`   $0: geen batterijgegevens: geen grafiek"
        STOP=ja
    }
}
    
[ -z "$STOP" ] &&  {
    #ls -l ../lst/mjs_${TYPE}_${STATIONID}_$PER.lst
    #ls -l ../../knmi/lst/knmi_thdrsN_$PER.lst
    ls -l ../lst/mjs_${TYPE}_${STATIONID}_sb_${PER}.lst
    ls -l ../../batt/lst/mjs_batt_2008_sb_${PER}.lst
    ls -l ../plt/mjs_${TYPE}_${STATIONID}_$PER.plt
    ../plt/mjs_${TYPE}_${STATIONID}_$PER.plt
    ls -l ../png/mjs_${TYPE}_${STATIONID}_$PER.png 
    echo "`date`   $0: gestopt"
}
echo ""
echo ""

