# $Id: meetjestad.nl:.../graphs/lmn/bin/haal_lmn_pm.sh $
# author: Peter Demmer

echo "$0: begin `date`"
echo ""

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
#PDDC="`date '+%H %M' | awk '{ printf("%02d%02d", $1, $2) }' | tr abc ABC`"
PDDC="`date '+%H%M'`"
[ ! -d ../log ] && mkdir ../log

# set up database access:
[ ! -f meetjestad_test.env ] && {
    echo "meetjestad_test.env niet gevonden; abort"
    exit 1
}
. ./meetjestad_test.env

STATIONS="NL10636 NL10821"
FORMULA=PM25
TIME=`date '+%H%M'`
case "$1" in
'06h') PERIOD=6hours ;;
'01d') PERIOD=1days ;;
'04d') PERIOD=4days ;;   # maximum 
'')    echo "usage: $0 06h"
       echo "usage: $0 2022-01-28T00:00:00+01:00.2022-02-01T00:00:00+01:00   # maximum 4 days"
       echo abort
       exit 1
       ;;
*)     PERIOD=other ;;
esac
[ -n "$PERIOD" ] && {
    START=`date --date=-$PERIOD -Iseconds`
    EINDE=`date -Iseconds`
}
[ "$PERIOD" = "other" ] && {
    START=`echo "$1" | awk -F. '{ print $1 }'`
    EINDE=`echo "$1" | awk -F. '{ print $2 }'`
}
echo 042 IK=$IK STATIONS=\"$STATIONS\" FORMULA=$FORMULA PERIOD=$PERIOD TIME=$TIME START=$START EINDE=$EINDE


for STATION in $STATIONS
do
IFS='
'
    JSON=../log/lmn_pm.$STATION.$PDDC.1json
    ERR=../log/lmn_pm.$STATION.$PDDC.2err
    JB=../log/lmn_pm.$STATION.$PDDC.3jb
    RAW=../log/lmn_pm.$STATION.$PDDC.4raw
    LST=../log/lmn_pm.$STATION.$PDDC.5lst
    SQL=../log/lmn_pm.$STATION.$PDDC.6sql
    echo 055 HIER=$HIER IK=$IK PDDC=$PDDC STATION=$STATION START=$START EINDE=$EINDE
    echo 056 JSON=$JSON ERR=$ERR
    
    URL="https://api2020.luchtmeetnet.nl/open_api/measurements?station_number=$STATION&order_by=timestamp_measured&order_direction=asc&page=1&formula=$FORMULA&start=$START&end=$EINDE"
    echo "URL=$URL "
    
    #echo "curl $URL > $JSON 2>$ERR"
    curl $URL > $JSON  2>$ERR
    RESULT=$?
    [ $RESULT != 0 -o ! -r $JSON ] && {
        echo "curl mislukt; abort"
        exit 1
    }
    
    echo "`ls -l $ERR`"
    # cat $JSON | jq . > $JB   #  jq not installed
    cat $JSON | sed 's/}, /},\n/g' | sed 's/"data": \[//' | sed 's/}/ }/' | grep -v pagination > $JB
    #grep timestamp_measured $JB | tail -1
    echo "last timestamp: `tail -1 $JB | awk '{ print $6 }'`"
    ls -l $JB
    
    cat $JB | awk '{ printf("%s  %s  %s  %s\n", $2, $4, $6, $8) }' > $RAW
    ls -l $RAW

    #cat $RAW   # STATION   TIMESTAMP   PM25   "PM25"

    TELLER=0
    for REGEL in `cat $RAW`
    do
        #echo REGEL=$REGEL
        STATION=`echo $REGEL | tr -d ' "' | awk -F, '{ printf("%s", $1) }'`
        TIMESTAMP=`echo $REGEL | tr -d ' "' | awk -F, '{ printf("%s", $3) }'`
        UNIXTIME=`date --date=$TIMESTAMP '+%s'`
        PM25=`echo $REGEL | awk -F, '{ printf("%.2f", $2) }'` 
        #echo "STATION=$STATION	TIMESTAMP=$TIMESTAMP	UNIXTIME=$UNIXTIME	PM25=$PM25"
        echo "$STATION	$TIMESTAMP	$UNIXTIME	$PM25" >> $LST
        SQL1="REPLACE INTO lmn_pm (timestamp, unixtime, source, lmn_station, pm25) VALUES ('$TIMESTAMP', $UNIXTIME, 'lmn', '$STATION', $PM25);" 
        echo SQL1=\"$SQL1\"
        echo $SQL1 >> $SQL
        TELLER=`expr $TELLER + 1`
    done
    echo 096 TELLER=$TELLER
    ls -l $LST
    ls -l $SQL
    
    mysql -u$DBUSER -D$DBASE -p$DBPASS < $SQL
    echo "invoer $STATION gereed: `date`"
    #rm $SQL
    echo ""
done

echo "$0: einde `date`" 
echo ""
echo ""

