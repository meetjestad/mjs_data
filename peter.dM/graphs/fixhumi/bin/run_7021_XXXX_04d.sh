#echo sleep 15:
#sleep 15 

#echo "$0 `date`: gestart; vorige liep 15 s"
echo "$0 `date`: gestart"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo PER=$PER

for SH in balc_fhum_????_${PER}.sh
do
    ls -l $SH
    [ -x $SH ] && {
        LST=../lst/`basename $SH .sh`.lst
        PLT=`basename $SH .sh`.plt
        PNG=`basename $SH .sh`.png
        #echo $SH:
        ./$SH | sed 's/^/    /'
        ls -l $LST | sed 's/^/    /'
        REGELS=`cat $LST | wc -l`
        [ $REGELS = 0 ] && {
            echo "    $LST: empty, skipping ..."
        } || {
            ls -l ../plt/$PLT
            ../plt/$PLT
            ls -l ../png/$PNG
            rm -f $LST
        }
        sleep 1
    }
    cd $HIER
    echo ""
done

echo "`date`   $0: gestopt"
echo ""
echo ""
