#
# $Id: graphs/maint/bin/run_mjs_repairs_XXXX_XXX.sh $
# $Author: Peter Demmer for Meetjestad! $


echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $5 }'`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png


for SH in run_mjs_repairs_[0-9][0-9A-C][0-9][0-9]_${PER}.sh
do
    REGELS=`cat ../lst/mjs_repair_????_cal_${PER}.lst | wc -l`
    [ $REGELS -lt 2 ] && {
        echo "    insufficient data, no graph"
    } || {
        RDATE="`basename $SH .sh | awk -F_ '{ print $4 }'`"
        PLT=../plt/mjs_repairs_${RDATE}_$PER.plt
        # echo PER=$PER SH=$SH RDATE=$RDATE PLT=$PLT | sed 's/^/    /'
        ls -l $PLT | sed 's/^/    /'
        $PLT
        ls -l ../png/mjs_repairs_${RDATE}_$PER.png | sed 's/^/    /'
    }
done

echo `date` $0: einde
echo ""

