cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`

PHYS="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"
DATUM="`echo $IK | awk -F_ '{ print $5 }'`"
echo "-- HIER=$HIER IK=$IK PHYS=$PHYS PERIODE=$PERIODE DATUM=$DATUM"

#STARTTIME="`date --date='31 december 2019' '+%Y-%m-%d %H:%M:%S'`"
#EINDETIME="`date --date='01 januari 2020' '+%Y-%m-%d %H:%M:%S'`"
STARTTIME="2020-04-26 00:00:00";
EINDETIME="2020-05-06 00:00:00";
#echo "-- PHYS=$PHYS PERIODE=$PERIODE STARTTIME=\"$STARTTIME\" EINDETIME=\"$EINDETIME\""


[ -r meetjestad_test.env ] || {
    echo "meetjestad_test.env not readable; abort"
    exit 1
}
. ./meetjestad_test.env


SQL="SELECT DISTINCT FROM_UNIXTIME(s.unixtime), 
s1.temp as t1, s2.temp as t2, s3.temp as t3, s4.temp as t4, s5.temp as t5, s6.temp as t6, 'NULL'
FROM sens7021 AS s 
LEFT JOIN sens7021 AS s1 ON (s.gmtijd = s1.gmtijd AND s1.port = 1) \
LEFT JOIN sens7021 AS s2 ON (s.gmtijd = s2.gmtijd AND s2.port = 2) \
LEFT JOIN sens7021 AS s3 ON (s.gmtijd = s3.gmtijd AND s3.port = 3) \
LEFT JOIN sens7021 AS s4 ON (s.gmtijd = s4.gmtijd AND s4.port = 4) \
LEFT JOIN sens7021 AS s5 ON (s.gmtijd = s5.gmtijd AND s5.port = 5) \
LEFT JOIN sens7021 AS s6 ON (s.gmtijd = s6.gmtijd AND s6.port = 6) \
WHERE s.source = 'meet6' 
AND FROM_UNIXTIME(s.unixtime) > '$STARTTIME' 
AND FROM_UNIXTIME(s.unixtime) < '$EINDETIME' 
ORDER BY s.unixtime ASC;"
SQL="$SQL
SELECT FROM_UNIXTIME(unixtime), 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', temp
FROM knmi_th
WHERE source = 'knmi' 
AND localtijd > '$STARTTIME' 
AND localtijd < '$EINDETIME' 
ORDER BY localtijd DESC; "

echo "-- PHYS=$PHYS PERIODE=$PERIODE STARTTIME='$STARTTIME' EINDETIME='$EINDETIME'"
#echo "-- SQL='$SQL'"

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9) }'

