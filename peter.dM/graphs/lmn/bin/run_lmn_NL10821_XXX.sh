echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
LMN_STATION=`echo $IK | awk -F_ '{ print $3 }'`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

for SH in run_lmn_${LMN_STATION}_0[1246][dwmy].sh
do
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done

echo `date` $0: einde
echo ""
echo ""
