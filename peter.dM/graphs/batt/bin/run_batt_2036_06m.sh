echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LST=../lst/mjs_${TYPE}_${NODE}_${PER}.lst
SBL=../lst/mjs_${TYPE}_${NODE}_sb_${PER}.lst
echo TYPE=$TYPE NODE=$NODE PER=$PER LST=$LST SBL=$SBL

php ../php/mjs_${TYPE}.php $NODE $PER > ../lst/mjs_${TYPE}_${NODE}_${PER}.lst
[ ! -s ../lst/mjs_${TYPE}_${NODE}_${PER}.lst ] && {
    echo ../lst/mjs_${TYPE}_${NODE}_${PER}.lst is leeg, geen grafiek
} || {
    ls -l $LST $SBL
    ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    #[ "$PER" = "02m" -o "$PER" = "06m" -o "$PER" = "02y" ] && rm -f $LST $SBL
    # note: ../../batt/lst/mjs_batt_2008_sb_02m.lst is also used by ../../light/plt/mjs_light_0068_02m.plt
    [ "$PER" = "06m" -o "$PER" = "02y" ] && rm -f $LST $SBL
    ls -l ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
