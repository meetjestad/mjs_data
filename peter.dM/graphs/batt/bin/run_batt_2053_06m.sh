# $Id: graphs/batt/bin/run_batt_????_???.sh $
# $Author: Peter Demmer $

echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LST=../lst/mjs_${TYPE}_${NODE}_${PER}.lst
SBL=../lst/mjs_${TYPE}_${NODE}_sb_${PER}.lst
echo "    TYPE=$TYPE NODE=$NODE PER=$PER LST=$LST SBL=$SBL"

STOP=""
#php ../php/mjs_${TYPE}2.php $NODE $PER > ../lst/mjs_${TYPE}_${NODE}_${PER}.lst
#php ../php/mjs_${TYPE}2.php $NODE $PER > /dev/null
php ../php/mjs_${TYPE}.php $NODE $PER > /dev/null
[ ! -s ../lst/mjs_${TYPE}_${NODE}_${PER}.lst ] && {
    echo "    ../lst/mjs_${TYPE}_${NODE}_${PER}.lst is empty, no graph"
    STOP=yes
}
UNIQ5=`cat ../lst/mjs_${TYPE}_${NODE}_sb_${PER}.lst | awk '{ print $5 }' | uniq | wc -l`
    [ $UNIQ5 -lt 2 ] && {
    echo "    ../lst/mjs_${TYPE}_${NODE}_sb_${PER}.lst column 5 constant, no graph"
    STOP=yes
}
[ -z "$STOP" ] && {
    ls -l $LST $SBL | sed 's/^/    /'
    ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    [ "$PER" = "06m" -o "$PER" = "02y" ] && rm -f $LST $SBL   # to save disk space
    # note: ../../batt/lst/mjs_batt_2008_sb_02m.lst is also used by ../../light/plt/mjs_light_0068_02m.plt
    [ "$PER" = "02m" ] && [ -z "`echo $LST | fgrep _2008_`" ] && rm -f $LST $SBL
    ls -l ../plt/mjs_${TYPE}_${NODE}_${PER}.plt | sed 's/^/    /'
    ls -l ../png/mjs_${TYPE}_${NODE}_${PER}.png | sed 's/^/    /'
}

echo "`date`   $0: gestopt"
echo ""
echo ""

