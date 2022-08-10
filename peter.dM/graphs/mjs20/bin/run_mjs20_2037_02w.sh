echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo TYPE=$TYPE NODE=$NODE PER=$PER

php ../php/getmjs20.php $NODE $PER
ls -l ../lst/mjs_${TYPE}_${NODE}_${PER}.lst
ls -l ../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst
ls -l ../lst/mjs_${TYPE}_${NODE}_pm_${PER}.lst

STOPTH=""
[ ! -s ../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst ] && {
    echo "../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst  is empty; no plot"
    STOPTH="ja"
}
[ -z "$STOPTH" ] && {
    ls -l ../plt/mjs_${TYPE}_${NODE}_th_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_th_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_th_${PER}.png
}

STOPPM=""
[ ! -s ../lst/mjs_${TYPE}_${NODE}_pm_${PER}.lst ] && {
    echo "../lst/mjs_${TYPE}_${NODE}_pm_${PER}.lst  is empty; no plot"
    STOPPM="ja"
}
UNIQ=`cat ../lst/mjs_${TYPE}_${NODE}_pm_${PER}.lst | awk '{ print $3, $4, $5, $6 }' | sort | uniq | wc -l`
[ $UNIQ -lt 2 ] && {
    echo "../lst/mjs_${TYPE}_${NODE}_pm_${PER}.lst  all the same; no plot"
    STOPPM="ja"
}
[ -z "$STOPPM" ] && {
    ls -l ../plt/mjs_${TYPE}_${NODE}_pm_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_pm_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_pm_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
