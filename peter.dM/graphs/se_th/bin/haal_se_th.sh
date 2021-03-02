# $Id:$
# meetjestad.nl:~/web/meetjestad.net/public_html/static/graphs/se_th/bin/haal_se_th.sh
# author: Peter Demmer

echo "gestart `date`"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%10, $2, $3, $4, $5) }' | tr abc ABC`"
PDDC="`date '+%H %M' | awk '{ printf("%02d%02d", $1, $2) }'`"
[ ! -d ../log ] && mkdir ../log
RUW=../log/se_th.$PDDC.ruw
LOG=../log/se_th.$PDDC.log
CSV=../log/se_th.$PDDC.csv
SQL=../log/se_th.$PDDC.sql
echo HIER=$HIER IK=$IK PDDC=$PDDC RUW=$RUW LOG=$LOG


[ -r external_url.env ] || {
    echo "external_url.env not found; abort"
    exit 1
}
. ./external_url.env

[ -r meetjestad_test.env ] || {
    echo "meetjestad_test.env not found; abort"
    exit 1
}
. ./meetjestad_test.env


# fetch the last 400 measurements from external source:
echo wget -O$RUW -o$LOG "$URL/$PAD/$PHP?header&number=12"   # every 5 minutes = 1 hour history
wget -O$RUW -o$LOG "$URL/$PAD/$PHP?header&number=12"   # every 5 minutes = 1 hour history
[ ! -r $RUW ] && {
    echo "wget mislukt; abort"
    exit 1
}
ls -l $RUW $LOG

# parse the raw html data into columns:
REGELS=`cat $RUW | wc -l`
EIND=` expr $REGELS - 2`
sed -n "2,${EIND}p" $RUW | sed -f se_th2csv.sed > $CSV
ls -l $CSV

# format the data into a SQL query:
sed -n '2,$p' $CSV | awk -F';' '{ printf("REPLACE INTO sensors_th (utctime, unixtime, source, dht11te, dht11hu, dht21te, dht21hu, dht22te, dht22hu, am2320te, am2320hu, bme280te, bme280hu, bme280pr, si7021te0, si7021hu0, si7021te1, si7021hu1, si7021te2, si7021hu2, si7021te3, si7021hu3, mcp9808te, apds9301lu ) VALUES (%c%s%c, %s, %c%s%c, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);\n", 39,$1,39, $2, 39,$3,39, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24) }' > $SQL


ls -l $SQL

# store the data in the database:
mysql -u$DBUSER -D$DBASE -p$DBPASS < $SQL
echo "invoer gereed: `date`"


echo "einde `date`" 
echo ""
echo ""

