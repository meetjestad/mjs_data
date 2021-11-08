cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

STATIONID="`echo $IK | awk -F_ '{ print $3 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"
case "$PER" in
	04d) PERIODE="4 days" ;;
	02w) PERIODE="2 weeks" ;;
	02m) PERIODE="2 months" ;;
	06m) PERIODE="6 months" ;;
	02y) PERIODE="2 years" ;;
	*)   PERIODE="1 day" ;;
esac

#STARTDATE="`date -d \"-$PERIODE\" '+%Y-%m-%d'`"
#ENDDATE="`date -d \"$STARTDATE +$PERIODE\" '+%Y-%m-%d'`"
#echo "STARTDATE=$STARTDATE ENDDATE=$ENDDATE"

cd ../php
php getmjshumi.php $STATIONID $PER
LST=../lst/mjs_fhum_${STATIONID}_$PER.lst
ls -l $LST
