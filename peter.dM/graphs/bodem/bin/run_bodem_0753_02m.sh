echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LSTC=../lst/mjs_${TYPE}_${NODE}_c_${PER}.lst
LSTT=../lst/mjs_${TYPE}_${NODE}_t_${PER}.lst
echo IK=$IK TYPE=$TYPE NODE=$NODE PER=$PER LSTC=$LSTC LSTT=$LSTT

php ../php/getbodem2.php $NODE $PER

ls -l $LSTC
REGELS=`cat $LSTC | wc -l`
[ $REGELS = 0 ] && {
    echo "$LSTC is empty, skipping ..."
} || {
    ls -l ../plt/mjs_${TYPE}_${NODE}_c_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_c_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_c_${PER}.png
}

ls -l $LSTT
REGELS=`cat $LSTT | wc -l`
[ $REGELS = 0 ] && {
    echo "$LSTT is empty, skipping ..."
} || {
    ls -l ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_t_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
