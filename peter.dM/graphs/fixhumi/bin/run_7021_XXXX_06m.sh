echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`

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
	sleep 1
     }
     rm -f ../lst/$LST
     cd $HIER
     echo ""
done

echo "`date`   $0: gestopt"
echo ""
echo ""
