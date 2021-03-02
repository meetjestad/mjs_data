cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%10, $2, $3, $4, $5) }' | tr abc ABC`"
PDDC="`date '+%H %M' | awk '{ printf("%02d%02d", $1, $2) }'`"
[ ! -d ../log ] && mkdir ../log
RUW=../log/sens7021.$PDDC.ruw
LOG=../log/sens7021.$PDDC.log
CSV=../log/sens7021.$PDDC.csv
SQL=../log/sens7021.$PDDC.sql
echo HIER=$HIER IK=$IK PDDC=$PDDC RUW=$RUW LOG=$LOG


[ -r meetjestad_test.env ] || {
    echo "meetjestad_test.env not found; abort"
    exit 1
}
. ./meetjestad_test.env


# fetch the last 400 measurements from balcon:
wget -O$RUW -o$LOG 'http://demmer.xs4all.nl:86/sens7021/sens7021.php?header&number=36'   # 36 = 6 every 5 minutes = 30 minutes history
[ ! -r $RUW ] && {
    echo "wget mislukt; abort"
        exit 1
}
ls -l $RUW $LOG

# parse the raw html data into columns:
REGELS=`cat $RUW | wc -l`
EIND=` expr $REGELS - 2`
sed -n "2,${EIND}p" $RUW | sed -f sens7021tocsv.sed > $CSV
ls -l $CSV

# format the data into a SQL query:
sed -n '2,$p' $CSV | awk -F';' '{ printf("REPLACE INTO sens7021 (gmtijd, unixtime, source, port, serial, temp, humi, dewp, heat, power, te9808, lux) VALUES (%c%s%c, %s, %c%s%c, %s, %c%s%c, %s, %s, %s, %s, %s, %s, %s);\n", 39,$1,39, $2, 39,$3,39, $4, 39,$5,39, $6, $7, $8, $9, $10, $11, $12) }' > $SQL


ls -l $SQL

# store the data in the database:
mysql -u$DBUSER -D$DBASE -p$DBPASS < $SQL
echo "invoer gereed: `date`"


echo "einde `date`" 
echo ""
echo ""

