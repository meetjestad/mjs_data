echo "`date`:   $0 gestart"

cd `dirname $0`
IK=`basename $0 .sh`
STATION="`echo $IK | awk -F_ '{ print $3 }'`"
PER="`echo $IK | awk -F_ '{ print $4 }'`"

FILES="../lst/lmn_pm_${STATION}_int_${PER}.lst ../../pm/lst/mjs_pm_0068_int_${PER}.lst ../../pm/lst/mjs_pm_2008_int_${PER}.lst ../../pm/lst/mjs_pm_2028_int_${PER}.lst"

for FILE in $FILES
do
	ls -l $FILE | sed 's/^/    /'
done

echo "#	localtime	NL10821	0068	2008	2028" > ../lst/lmn_pm_${STATION}_pas_${PER}.lst
for TIMESTAMP in `cat ../lst/lmn_pm_${STATION}_int_${PER}.lst | awk '{ print $1 }'`
do
    VAL0="`grep $TIMESTAMP ../lst/lmn_pm_${STATION}_int_${PER}.lst | head -1 | awk '{ print $4 }'`"
    [ -z "$VAL0" ] && VAL0='?'
    VAL1="`grep $TIMESTAMP ../../pm/lst/mjs_pm_0068_int_${PER}.lst | head -1 | awk '{ print $4 }'`"
    [ -z "$VAL1" ] && VAL1='?'
    VAL2="`grep $TIMESTAMP ../../pm/lst/mjs_pm_2008_int_${PER}.lst | head -1 | awk '{ print $4 }'`"
    [ -z "$VAL2" ] && VAL2='?'
    VAL3="`grep $TIMESTAMP ../../pm/lst/mjs_pm_2028_int_${PER}.lst | head -1 | awk '{ print $4 }'`"
    [ -z "$VAL3" ] && VAL3='?'
    echo "$TIMESTAMP	$VAL0	$VAL1	$VAL2	$VAL3" >> ../lst/lmn_pm_${STATION}_pas_${PER}.lst
done
ls -l ../lst/lmn_pm_${STATION}_pas_${PER}.lst | sed 's/^/    /'

echo "`date`:   $0 gestopt"
echo ""

