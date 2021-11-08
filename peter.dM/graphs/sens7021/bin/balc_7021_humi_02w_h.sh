cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

PHYS="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
SMH="`echo $IK | awk -F_ '{ print $5 }'`"

case $PERIODE in
    01d) STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    04d) STARTTIME="`date --date='-4 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
    02w) STARTTIME="`date --date='-2 weeks'  '+%Y-%m-%d %H:%M:%S'`" ;;
    02m) STARTTIME="`date --date='-2 months' '+%Y-%m-%d %H:%M:%S'`" ;;
    06m) STARTTIME="`date --date='-6 months' '+%Y-%m-%d %H:%M:%S'`" ;;
    *)   STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`" ;;
esac


[ -r meetjestad_test.env ] || {
    echo "meetjestad_test.env not readable; abort"
    exit 1
}
. ./meetjestad_test.env


SQL="SELECT DISTINCT FROM_UNIXTIME(s.unixtime), 
s1.humi AS h1, s2.humi AS h2, s3.humi AS h3, s4.humi AS h4, s5.humi AS h5, s6.humi AS h6, 'NULL'
FROM sens7021 AS s 
LEFT JOIN sens7021 AS s1 ON (s.gmtijd = s1.gmtijd AND s1.port = 1) 
LEFT JOIN sens7021 AS s2 ON (s.gmtijd = s2.gmtijd AND s2.port = 2) 
LEFT JOIN sens7021 AS s3 ON (s.gmtijd = s3.gmtijd AND s3.port = 3) 
LEFT JOIN sens7021 AS s4 ON (s.gmtijd = s4.gmtijd AND s4.port = 4) 
LEFT JOIN sens7021 AS s5 ON (s.gmtijd = s5.gmtijd AND s5.port = 5) 
LEFT JOIN sens7021 AS s6 ON (s.gmtijd = s6.gmtijd AND s6.port = 6) 
WHERE s.source = 'meet6' AND FROM_UNIXTIME(s.unixtime) > '$STARTTIME' ORDER BY s.unixtime ASC;"
SQL="$SQL
SELECT FROM_UNIXTIME(unixtime), 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', humi
FROM knmi_th
WHERE source = 'knmi' AND localtijd > '$STARTTIME' ORDER BY localtijd DESC; "

echo "-- PHYS=$PHYS PERIODE=$PERIODE STARTTIME=\"$STARTTIME\""
#echo "-- SQL=\"$SQL\""

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9) }'

