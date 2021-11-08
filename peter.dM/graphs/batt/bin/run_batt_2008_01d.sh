echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LST=../lst/mjs_${TYPE}_${NODE}_sb_${PER}.lst
KLST=../../knmi/lst/knmi_thdrs_${PER}.lst
echo TYPE=$TYPE NODE=$NODE PER=$PER LST=$LST KLST=$KLST

php ../php/mjs_${TYPE}.php $NODE $PER 
ls -l $LST 
[ ! -s $LST ] && {
    echo $LST is leeg, geen grafiek
    SKIP=ja
}
[ ! -s $KLST ] && {
    echo $KLST is leeg, geen grafiek
    SKIP=ja
}
UNIQ=`cat $LST | awk '{ print $5 }' | sort | uniq | wc -l`
[ "$UNIQ" -lt 2 ] && {
    echo "$LST kolom 5 bevat slechts 1 waarde, geen grafiek"
    SKIP=ja
}
UNIQ=`cat $KLST | awk '{ print $7 }' | sort | uniq | wc -l`
[ "$UNIQ" -lt 2 ] && {
    echo "$KLST kolom 7 bevat slechts 1 waarde, geen grafiek"
    SKIP=ja
}

[ -z "$SKIP" ] && {
    ls -l ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
