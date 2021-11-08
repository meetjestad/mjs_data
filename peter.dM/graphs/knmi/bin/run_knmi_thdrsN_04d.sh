echo "`date`   $0: gestart"
cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
LST=`echo $IK | awk -F_ '{ printf("%s_%s_%s.lst", $2, $3, $4) }'`
#echo LST=$LST

#PHYS="`echo $IK | awk -F_ '{ print $3 }'`"
PERIODE="`echo $IK | awk -F_ '{ print $4 }'`"

case $PERIODE in
    04d) STARTTIME="`date --date='-4 days'   '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=97
	 ;;
    02w) STARTTIME="`date --date='-2 weeks'  '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=337
	 ;;
    02m) STARTTIME="`date --date='-2 months' '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=1465
	 ;;
    06m) STARTTIME="`date --date='-6 months' '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=4373
	 ;;
    02y) STARTTIME="`date --date='-2 years'  '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=17492
	 ;;
    *)   STARTTIME="`date --date='-1 days'   '+%Y-%m-%d %H:%M:%S'`"
	 LIMIT=25
	 ;;
esac

[ ! -f meetjestad_test.env ] && {
    echo "meetjestad_test.env niet gevonden, abort"
    exit 1
}
. ./meetjestad_test.env

SQL="SELECT FROM_UNIXTIME(unixtime), temp, humi, dauw, regen, regen7d, straling FROM knmi_th \
WHERE knmi_station = 260  ORDER BY unixtime DESC limit $LIMIT"
#WHERE localtijd > '$STARTTIME' ORDER BY unixtime ASC; "
echo "    # SQL=$SQL"

echo $SQL | mysql -N -u$DBUSER -D$DBASE -p$DBPASS | awk '{ printf("%s.%s %.1f %.0f %.1f %.1f %.2f %.0f\n", $1, $2, $3, $4, $5, $6, $7, $8) }' > ../../knmi/lst/$LST
ls -l ../../knmi/lst/$LST | sed 's/^/    /'

echo "`date`   $0: gestopt"
echo ""
echo ""

