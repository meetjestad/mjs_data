echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
LSTR=../lst/mjs_${TYPE}_${NODE}_ra_${PER}.lst
LSTC=../lst/mjs_${TYPE}_${NODE}_ca_${PER}.lst
echo TYPE=$TYPE NODE=$NODE PER=$PER LSTC=$LSTC 

php ../php/mjs_${TYPE}.php $NODE $PER 

OK=""
[ ! -s $LSTC ] && {
    echo $LSTC is leeg, geen grafiek
    OK=nee
}

REGELS=`grep -v '?' $LSTC | wc -l`
[ $REGELS -lt 2 ] && {
    echo $LSTC bevat minder dan 2 geldige waarden, geen grafiek
    OK=nee
}

[ "$OK" != "nee" ] && {
    ls -l $LSTC 
    ../plt/mjs_${TYPE}_${NODE}_te_${PER}.plt
    ../plt/mjs_${TYPE}_${NODE}_hu_${PER}.plt
    [ "$PER" = "06m" -o "$PER" = "02y" ] && {
        echo "rm $LSTR $LSTC ..."
        rm $LSTR $LSTC
    }
    ls -l ../plt/mjs_${TYPE}_${NODE}_te_${PER}.plt
    ls -l ../plt/mjs_${TYPE}_${NODE}_hu_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${NODE}_te_${PER}.png
    ls -l ../png/mjs_${TYPE}_${NODE}_hu_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
