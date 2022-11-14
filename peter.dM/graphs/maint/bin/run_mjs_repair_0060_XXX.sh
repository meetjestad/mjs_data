#
# $Id: graphs/maint/bin/run_mjs_repair_XXXX_XXX.sh $
# $Author: Peter Demmer for Meetjestad! $


echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
STATION=`echo $IK | awk -F_ '{ print $4 }'`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

for SH in run_mjs_repair_${STATION}_0[1246][dwmy].sh
do
    echo SH=$SH
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done

echo `date` $0: einde
echo ""
echo ""
