#
# $Id: graphs/maint/bin/run_mjs_repair_9999_PPP.sh $
# $Author: Peter Demmer for Meetjestad! $


echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATION=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
#echo "    IK=$IK STATION=$STATION PER=$PER"

echo "`ls -l ../php/mjs_repair.php` $STATION $PER"
ls -l ../lst/mjs_repair_${STATION}_raw_$PER.lst 
AANTAL=`cat ../lst/mjs_repair_${STATION}_raw_$PER.lst | wc -l`
[ $AANTAL -eq 0 ] && {
    echo "no data, no graph"
} || {
    php ../php/mjs_repair.php $STATION $PER
    ls -l ../lst/mjs_repair_${STATION}_cal_$PER.lst 
    ls -l ../lst/mjs_repair_${STATION}_met_$PER.json 
}

echo "`date`   $0: einde"
echo ""

