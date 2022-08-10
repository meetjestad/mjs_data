echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
GROUP=`echo $IK | awk -F_ '{ print $3 }'`
STATION=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
#echo "    IK=$IK GROUP=$GROUP STATION=$STATION PER=$PER"

echo "    `ls -l ../php/mjs_${GROUP}.php` $STATION $PER"
php ../php/mjs_${GROUP}.php $STATION $PER
ls -l ../lst/mjs_${GROUP}_${STATION}_raw_$PER.lst  | sed 's/^/    /'
ls -l ../lst/mjs_${GROUP}_${STATION}_cal_$PER.lst  | sed 's/^/    /'

echo "`date`   $0: einde"
echo ""

