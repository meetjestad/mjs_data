echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LSTK=../../knmi/lst/knmi_thdrs_${PER}.lst # ../../knmi/lst/knmi_thdrsT_04d.lst
LSTRA=../lst/mjs_${TYPE}_${NODE}_ra_${PER}.lst
LSTCA=../lst/mjs_${TYPE}_${NODE}_ca_${PER}.lst
echo IK=$IK TYPE=$TYPE NODE=$NODE PER=$PER LSTRA=$LSTRA LSTCA=$LSTCA | sed 's/^/    /'

php ../php/mjs_bodem.php $NODE $PER

ls -l $LSTRA | sed 's/^/    /'
ls -l $LSTCA | sed 's/^/    /'

#LINESCA=`fgrep -v '#' $LSTCA | wc -l`
LINESCA=`fgrep -v '#' $LSTCA | awk '{ print $4, $5, $6, $7 }' | uniq | wc -l`
[ $LINESCA -le 1 ] && {
    echo "    $LSTCA minder dan 2 verschillende regels, geen grafiek"
} || {
    ls -l ../plt/mjs_${TYPE}_${NODE}_m_${PER}.plt | sed 's/^/    /'
    ../plt/mjs_${TYPE}_${NODE}_m_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_m_${PER}.png | sed 's/^/    /'

    ls -l ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt | sed 's/^/    /'
    ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_t_${PER}.png | sed 's/^/    /'
}
 
[ "$PER" = "06m" ] && {
    echo "    removing $LSTRA and $LSTCA ..."
    rm $LSTRA $LSTCA
}

echo "`date`   $0: gestopt"
echo ""
