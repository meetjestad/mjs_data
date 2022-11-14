echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
STATION=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
#echo "    IK=$IK STATION=$STATION PER=$PER"

echo "`ls -l ../php/mjs_repair.php` $STATION $PER"
php ../php/mjs_repair.php $STATION $PER
ls -l ../lst/mjs_repair_${STATION}_raw_$PER.lst 
ls -l ../lst/mjs_repair_${STATION}_cal_$PER.lst 
ls -l ../lst/mjs_repair_${STATION}_met_$PER.json 
#GEVONDEN="`egrep -v '^-- ' ../lst/mjs_repair_${STATION}_raw_$PER.lst`"
#[ -z "$GEVONDEN" ] && {
    #echo "`date`   $0: niets gevonden"
#} || {
    #echo "`ls -l ../php/mjs_repair.php` $STATION $PER"
    #php ../php/mjs_repair.php $STATION $PER
    #echo "`ls -l ../lst/mjs_repair_${STATION}_cal_$PER.lst`"
#
    echo "`date`   $0: gestopt"
#}
echo ""

