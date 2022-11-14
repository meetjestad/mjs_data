echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo TYPE=$TYPE NODE=$NODE PER=$PER

php ../php/getmjsV1.php $NODE $PER

ls -l ../../knmi/lst/knmi_thdrs_${PER}.lst | sed 's/^/    /'
ls -l ../lst/mjs_${TYPE}_${NODE}_${PER}.lst | sed 's/^/    /'
ls -l ../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst | sed 's/^/    /'

STOPK=""
LINES=`cat ../../knmi/lst/knmi_thdrs_${PER}.lst | wc -l`
[ $LINES -lt 2 ] && {
    echo "    ../../knmi/lst/knmi_thdrs_${PER}.lst is empty; no plots"
    STOPK="ja"
} 

STOPTH=""
LINES=`cat ../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst | wc -l`
[ $LINES -lt 2 ] && {
    echo "    ../lst/mjs_${TYPE}_${NODE}_th_${PER}.lst is empty; no th plot"
    STOPTH="ja"
}
[ -z "$STOPK$STOPTH" ] && {
    ls -l ../plt/mjs_${TYPE}_${NODE}_th_${PER}.plt | sed 's/^/    /'
    ../plt/mjs_${TYPE}_${NODE}_th_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_th_${PER}.png | sed 's/^/    /'
}

echo "`date`   $0: gestopt"
echo ""

