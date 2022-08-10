echo `date` $0: gestart
# PER=$PER SH=$SH:
cd `dirname $0` 
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

for SH in ./run_lmn_NL[0-9][0-9][0-9][0-9][0-9]_${PER}.sh
do
    [ -f $SH ] && ls -l $SH | sed 's/^/    /'
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done

echo `date` $0: einde
echo ""
echo ""
