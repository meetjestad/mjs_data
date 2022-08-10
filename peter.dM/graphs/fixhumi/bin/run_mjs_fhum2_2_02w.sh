echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
GROUP=`echo $IK | awk -F_ '{ print $3 }'`
N=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
RAW=../lst/mjs_fhum2_${N}_raw_$PER.lst
CAL=../lst/mjs_fhum2_${N}_cal_$PER.lst
#echo "    IK=$IK GROUP=$GROUP N=$N PER=$PER RAW=$RAW CAL=$CAL"

sort ../lst/mjs_fhum2_0068_int_${PER}.lst ../lst/mjs_fhum2_0176_int_${PER}.lst > $RAW
ls -l $RAW | sed 's/^/    /'
IFS='
'
rm -f $CAL
for REGEL in `cat $RAW`
do
    #echo REGEL="$REGEL"
    STATION="`echo $REGEL | awk '{ print $3 }'`"
    #echo STATION=$STATION
    case "$STATION" in
        68) LOCTIMEHI="`echo $REGEL | awk '{ print $1 }'`" 
            UNIXTIMEHI="`echo $REGEL | awk '{ print $2 }'`" 
            TEMPHI="`echo $REGEL | awk '{ print $4 }'`"
            DEWPHI="`echo $REGEL | awk '{ print $6 }'`"
            ;;
        176) LOCTIMELO="`echo $REGEL | awk '{ print $1 }'`" 
             UNIXTIMELO="`echo $REGEL | awk '{ print $2 }'`" 
             TEMPLO="`echo $REGEL | awk '{ print $4 }'`"
        ;;
    esac
    [ "$UNIXTIMEHI" = "$UNIXTIMELO" ] && {
        DEWPHI=`echo $DEWPHI | awk '{ printf("%.2f", $1 - 2. ) }'`
        HUMILO="`php ../php/cli_tempdewp2humi.php $TEMPLO $DEWPHI`"
        #echo LOCTIMEHI=$LOCTIMEHI TEMPHI=$TEMPHI DEWPHI=$DEWPHI TEMPLO=$TEMPLO HUMILO=$HUMILO
	echo "$LOCTIMEHI	$UNIXTIMEHI	$TEMPLO	$HUMILO	$DEWPHI" >> $CAL
    }
done

ls -l $CAL | sed 's/^/    /'

PLT=../plt/mjs_${GROUP}_${N}_${PER}.plt
ls -l $PLT | sed 's/^/    /'
[ -x $PLT ] && $PLT
PNG="`echo $PLT | sed 's/plt/png/g'`"
ls -l $PNG | sed 's/^/    /'

echo "`date`   $0: einde"
echo ""

