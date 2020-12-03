# $Id:$
# meetjestad.nl:~meetjestad/.../bin/haal_knmi_th.sh
# author: Peter Demmer

echo "gestart `date`"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%10, $2, $3, $4, $5) }' | tr abc ABC`"
[ ! -d ../log ] && mkdir ../log
RUW=../log/knmi_th.$PDDC.ruw
LOG=../log/knmi_th.$PDDC.log
CSV=../log/knmi_th.$PDDC.csv
SQL=../log/knmi_th.$PDDC.sql
echo HIER=$HIER IK=$IK PDDC=$PDDC 
echo RUW=$RUW LOG=$LOG

# fetch the last measurements from the KNMI:
# last measurement returnes data up to yesterday 24h00
# in general available from 12:00 the next day, so latency = 12..36 h
# T        = Temperatuur (in 0.1 graden Celsius) op 1.50 m hoogte tijdens de waarneming; 
# TD       = Dauwpuntstemperatuur (in 0.1 graden Celsius) op 1.50 m hoogte tijdens de waarneming; 
# U        = Relatieve vochtigheid (in procenten) op 1.50 m hoogte tijdens de waarneming; 
# RH       = Uursom van de neerslag (in 0.1 mm) (-1 voor <0.05 mm); 
# Q        = Globale straling (in J/cm2) per uurvak; 
#START='2016061101'
START=`date --date='-2 days' '+%Y%m%d01'`
END=`date '+%Y%m%d24'`
URL='http://projects.knmi.nl/klimatologie/uurgegevens/getdata_uur.cgi'
POST="start=$START&end=$END&vars=T:TD:U:RH:Q&stns=260"
echo URL=$URL 
echo POST=$POST

echo "wget -O$RUW -o$LOG --post-data='$POST' $URL"
wget -O$RUW -o$LOG --post-data="$POST" $URL   
RESULT=$?
[ $RESULT != 0 -o ! -r $RUW ] && {
    echo "wget mislukt; abort"
    exit 1
}
NO_RUW=`grep -v '^#' $RUW | wc -l`
echo "`ls -l $RUW`   ($NO_RUW)"
echo "`ls -l $LOG`"


# parse the raw html data into columns:
grep -v '^#' $RUW | sed -f knmi_th2csv.sed | tee $CSV.all | egrep -v ' ,| $' > $CSV
NO_CSV=`cat $CSV | wc -l`
echo "`ls -l $CSV`   ($NO_CSV)"
tail -3 $CSV | sed 's/^/    /'


# format the data into a SQL query:
sed -n '1,$p' $CSV | awk -F',' '{ printf("REPLACE INTO knmi_th (localtijd, source, temp, dauw, humi, regen, straling) VALUES (%c%s-%s-%s %02d:59:59%c, %c%s%c, %2.1f, %2.1f, %2.0f, %2.2f, %2.0f);\n", 39,substr($2,1,4),substr($2,5,2),substr($2,7,2),$3-1,39, 39,"knmi",39, .1*$4, .1*$5, $6, .1*$7, $8) }' > $SQL
NO_SQL=`cat $SQL | wc -l`
echo "`ls -l $SQL`   ($NO_SQL)"

[ $NO_RUW -ne $NO_CSV ] && {
    echo ""
    echo "*** WAARSCHUWING: ruwe data regels = $NO_RUW != $NO_CSV = CSV regels ***"
    echo ""
}

# store the data in the database:
[ ! -f meetjestad_test.env ] && {
    echo meetjestad_test.env niet gevonden
}
. ./meetjestad_test.env

mysql -u$DBUSER -D$DBASE -p$DBPASS < $SQL
echo "invoer gereed: `date`"

# update unix timestamp:
echo "UPDATE knmi_th SET unixtime = UNIX_TIMESTAMP(localtijd) WHERE source = 'knmi' AND unixtime IS NULL" | mysql -u$DBUSER -D$DBASE -p$DBPASS

# update regen7d:
echo "`date`" >> ../log/upd_knmi_regen7d.log
php ../php/upd_knmi_regen7d.php >> ../log/upd_knmi_regen7d.log
echo "" >> ../log/upd_knmi_regen7d.log

echo "einde `date`" 
echo ""
echo ""

