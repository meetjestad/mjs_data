echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LSTK=../../knmi/lst/knmi_thdrs_${PER}.lst # ../../knmi/lst/knmi_thdrsT_04d.lst
LRAW=../lst/mjs_${TYPE}_${NODE}_ra_${PER}.lst
LCAL=../lst/mjs_${TYPE}_${NODE}_ca_${PER}.lst
echo IK=$IK TYPE=$TYPE NODE=$NODE PER=$PER LRAW=$LRAW LCAL=$LCAL | sed 's/^/    /'

php ../php/mjs_boom.php $NODE $PER

ls -l $LRAW $LCAL | sed 's/^/    /'

LINESCA=`cat $LCAL | wc -l`
[ $LINESCA -le 1 ] && {
    echo $LCAL minder dan 2 regels, geen grafiek
} || {
ls -l ../plt/mjs_${TYPE}_${NODE}_m_${PER}.plt | sed 's/^/    /'
../plt/mjs_${TYPE}_${NODE}_m_${PER}.plt
ls -l ../png/mjs_${TYPE}_${NODE}_m_${PER}.png | sed 's/^/    /'

ls -l ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt | sed 's/^/    /'
../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
ls -l ../png/mjs_${TYPE}_${NODE}_t_${PER}.png | sed 's/^/    /'
}

echo "`date`   $0: gestopt"
echo ""
