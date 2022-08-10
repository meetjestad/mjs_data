echo "`date` $0: begin"

cd `dirname $0` 
IK=`basename $0 .sh`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

PER=`echo $IK | awk -F_ '{ print $4 }'`
#echo IK=$IK PER=$PER

for SH in ./run_pm_[0-9][0-9][0-9][0-9]_$PER.sh
do
    [ -x $SH ] && ./$SH  | sed 's/^/    /'
done

echo "`date` $0: einde"
echo ""

