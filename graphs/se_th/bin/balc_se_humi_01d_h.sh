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
    echo "meetjestad_test.env not found; abort"
    exit 1
}
. meetjestad_test.env


SQL="SELECT FROM_UNIXTIME(unixtime), dht11hu, dht21hu, dht22hu, am2320hu, bme280hu, si7021hu0, si7021hu1, si7021hu2, si7021hu3, 'NULL' FROM sensors_th \
     WHERE source = 'meet6' AND FROM_UNIXTIME(unixtime) > '$STARTTIME' ORDER BY unixtime ASC;"
SQL="$SQL SELECT FROM_UNIXTIME(unixtime), 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', humi FROM knmi_th \
     WHERE source = 'knmi' AND localtijd > '$STARTTIME' ORDER BY localtijd DESC; "


echo "-- PHYS=$PHYS PERIODE=$PERIODE STARTTIME=\"$STARTTIME\""
echo "SQL=\"$SQL\""

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %s %s %s %s %s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) }'

