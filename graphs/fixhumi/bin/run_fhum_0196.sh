cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
NODE=`echo $IK | awk -F_ '{ printf("%04d", $3) }'`

for PER in 04d 02w 02m 06m 02y
do
    SH=run_fhum_${NODE}_${PER}.sh
    [ -x ./$SH ] && {
        ./$SH
    }
done
