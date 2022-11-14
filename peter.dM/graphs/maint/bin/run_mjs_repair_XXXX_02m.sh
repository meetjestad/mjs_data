#
# $Id: graphs/maint/bin/run_mjs_repair_XXXX_PPP.sh $
# $Author: Peter Demmer for Meetjestad! $


echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $5 }'`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

echo PER=$PER 
for SH in run_mjs_repair_[0-9][0-9][0-9][0-9]_${PER}.sh
do
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done
echo `date` $0: einde
echo ""
echo ""

./run_mjs_repairs_XXXX_${PER}.sh
echo ""

