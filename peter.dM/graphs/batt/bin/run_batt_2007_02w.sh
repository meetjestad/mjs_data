echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo TYPE=$TYPE NODE=$NODE PER=$PER

php ../php/mjs_${TYPE}.php $NODE $PER > ../lst/mjs_${TYPE}_${NODE}_${PER}.lst
[ ! -s ../lst/mjs_${TYPE}_${NODE}_${PER}.lst ] && {
    echo ../lst/mjs_${TYPE}_${NODE}_${PER}.lst is leeg, geen grafiek
} || {
    ls -l ../lst/mjs_${TYPE}_${NODE}_${PER}.lst
    ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    ls -l ../plt/mjs_${TYPE}_${NODE}_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
