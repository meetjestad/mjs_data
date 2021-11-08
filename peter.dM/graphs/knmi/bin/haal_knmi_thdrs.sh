# $Id: meetjestad.nl:.../bin/haal_knmi_thdrs.sh $
# author: Peter Demmer

echo "gestart `date`"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
#PDDC="`date '+%Y %m %d %H %M' | awk '{ printf("%d%x%02d-%02d%02d", $1%10, $2, $3, $4, $5) }' | tr abc ABC`"
PDDC="`date '+%H %M' | awk '{ printf("%02d%02d", $1, $2) }' | tr abc ABC`"
[ ! -d ../log ] && mkdir ../log

# set up database access:
[ ! -f meetjestad_test.env ] && {
    echo "meetjestad_test.env niet gevonden; abort"
    exit 1
}
. ./meetjestad_test.env

IFS='
'

# 260 de Bilt  52.10 N,     5.18 O
# 375 Volkel   51.658470 N, 5.706616 O
# 377 Ell      51.196648 N, 5.762652 O
# 391 Arcen    51.501089 N, 6.904213 O

#for KST in 260 375 377 391
for KST in 260 
do
    LOG=../log/knmi_thdrs.$KST.$PDDC.1log
    ZIP=../log/knmi_thdrs.$KST.$PDDC.2zip
    TXT=../log/uurgeg_${KST}_2021-2030.txt
    RUW=../log/knmi_thdrs.$KST.$PDDC.4ruw
    CSV=../log/knmi_thdrs.$KST.$PDDC.5csv
    LST=../log/knmi_thdrs.$KST.$PDDC.6lst
    SQL=../log/knmi_thdrs.$KST.$PDDC.7sql
    echo HIER=$HIER IK=$IK PDDC=$PDDC 
    echo RUW=$RUW LOG=$LOG
    
    # fetch the last measurements from the KNMI:
    # last measurement returns data up to yesterday 24h00
    # in general available from 12:00 the next day, so latency = 12..36 h
    # T        = Temperatuur (in 0.1 graden Celsius) op 1.50 m hoogte tijdens de waarneming; 
    # TD       = Dauwpuntstemperatuur (in 0.1 graden Celsius) op 1.50 m hoogte tijdens de waarneming; 
    # U        = Relatieve vochtigheid (in procenten) op 1.50 m hoogte tijdens de waarneming; 
    # RH       = Uursom van de neerslag (in 0.1 mm) (-1 voor <0.05 mm); 
    # Q        = Globale straling (in J/cm2) per uurvak; 
    URL="https://cdn.knmi.nl/knmi/map/page/klimatologie/gegevens/uurgegevens/uurgeg_${KST}_2021-2030.zip"
    echo "URL=$URL "
    
    echo "wget -O$ZIP -o$LOG $URL"
    wget -O$ZIP -o$LOG $URL   
    RESULT=$?
    [ $RESULT != 0 -o ! -r $ZIP ] && {
        echo "wget mislukt; abort"
        exit 1
    }
    cd ../log
    rm -f ../log/$TXT
    unzip $ZIP
    cd -
    
    NO_TXT=`grep -v '^#' $TXT | wc -l`
    echo "`ls -l $ZIP`"
    echo "`ls -l $TXT`   ($NO_TXT)"
    echo "`ls -l $LOG`"
    
    grep '# STN' $TXT > $RUW
    # sed -n '34,$p' $TXT >> $RUW   # alles sinds 1-1-2021
    tail -48 $TXT >> $RUW   # de laatste 2 dagen
    ls -l $RUW
    
    cat $RUW | awk -F, '{ printf("%s,  %s,  %s,  %s,  %s,  %s,  %s,  %s\n", $1, $2, $3, $8, $10, $12, $14, $18) }' > $CSV
    ls -l $CSV
    
    TELLER=0
    for REGEL in `cat $CSV`
    do
        [ $TELLER -eq 0 ] && {
            echo $REGEL > $LST
            echo "-- $REGEL" > $SQL
        } || {    
            STATION_ID=`echo $REGEL | awk -F, '{ printf("%03d", $1   ) }'`
            YYYYMMDD=`echo $REGEL   | awk -F, '{ printf("%08d", $2   ) }'`
            HH=`echo $REGEL         | awk -F, '{ printf("%02d", $3-1 ) }'`   # Hour in UTC - 1
            TEMP=`echo $REGEL       | awk -F, '{ printf("%5.1f", $4/10) }'`
            DAUW=`echo $REGEL       | awk -F, '{ printf("%5.1f", $5/10) }'`
            STRAL=`echo $REGEL      | awk -F, '{ printf("%3d",  $6   ) }'`
            REGEN=`echo $REGEL      | awk -F, '{ printf("%5.1f", $7/10) }'`
            HUMI=`echo $REGEL       | awk -F, '{ printf("%3d",  $8   ) }'`
            [ "$REGEN" = " -0.1" ] && REGEN=" 0.05"
            YYYY=`echo $YYYYMMDD | sed 's/....$//'`
            MM=`echo $YYYYMMDD | sed 's/^....//' | sed 's/..$//'`
            DD=`echo $YYYYMMDD | sed 's/^......//'`
            UNIXTIME=`date -u --date="$YYYY-$MM-$DD $HH:59:59" +'%s'`
            UNIXTIME=$(( $UNIXTIME + 1 ))
            LOCALTIME="`date -d@$UNIXTIME '+%Y-%m-%d %H:%M:%S'`"
            echo "$STATION_ID	$KST	$YYYY-$MM-$DD $HH:59:59	$UNIXTIME	$LOCALTIME	$TEMP	$DAUW	$STRAL	$REGEN	$HUMI" >> $LST
            echo "REPLACE INTO knmi_th (localtijd, unixtime, source, knmi_station, temp, dauw, humi, regen, straling) VALUES ('$LOCALTIME', $UNIXTIME, 'knmi', $KST, $TEMP, $DAUW, $HUMI, $REGEN, $STRAL);" >> $SQL
        }
        TELLER=`expr $TELLER + 1`
    done
    ls -l $LST
    ls -l $SQL
    
    mysql -u$DBUSER -D$DBASE -p$DBPASS < $SQL
    echo "invoer $KST gereed: `date`"
    echo ""

    # update regen7d:
    echo "`date`" > ../log/upd_knmi_regen7d.log
    php ../php/upd_knmi_regen7d.php $KST >> ../log/upd_knmi_regen7d.log
    echo "" >> ../log/upd_knmi_regen7d.log
done
echo "" >> ../log/upd_knmi_regen7d.log

echo "einde `date`" 
echo ""
echo ""

