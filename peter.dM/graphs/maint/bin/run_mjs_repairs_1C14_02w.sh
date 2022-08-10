#
# $Id: graphs/maint/bin/run_mjs_repairs_1C14_XXX.sh $
# $Author: Peter Demmer for Meetjestad! $


echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
RDATE=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`

for SH in run_mjs_repairs_${RDATE}_${PER}.sh
do
    ls -l ../lst/mjs_repair_????_cal_${PER}.lst | sed 's/^/    /'
    REGELS=`cat ../lst/mjs_repair_????_cal_${PER}.lst | wc -l`
    [ $REGELS -lt 2 ] && {
        echo "    insufficient data, no graph"
    } || {
        ls -l ../plt/mjs_repairs_${RDATE}_$PER.plt  | sed 's/^/    /'
        ../plt/mjs_repairs_${RDATE}_$PER.plt
        ls -l ../png/mjs_repairs_${RDATE}_$PER.png  | sed 's/^/    /'
    }
done

echo `date` $0: einde
echo ""
echo ""
