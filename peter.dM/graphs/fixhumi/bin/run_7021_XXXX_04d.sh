#sleep 10   # vorige script loopt 10 s

#echo "`date`   $0: gestart, loopt ~ 5 s"
echo "`date`   $0"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo PER=$PER

for SH in balc_fhum_????_${PER}.sh
do
    ls -l $SH
    [ -x $SH ] && {
        LST=`basename $SH .sh`.lst
        PLT=`basename $SH .sh`.plt
        #./$SH > $LST
	echo $SH:
        ./$SH
        ls -l ../lst/$LST
        ls -l ../plt/$PLT
        cd ../plt
        ./$PLT
        #rm -f ../lst/$LST
	sleep 1
     }
     cd $HIER
     echo ""
done

echo "`date`   $0: gestopt"
echo ""
echo ""
