echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../plt ] && mkdir ../plt

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
SMH=`echo $IK | awk -F_ '{ print $5 }'`
echo TYPE=$TYPE PER=$PER SMH=$SMH

./perf_${TYPE}_${PER}_$SMH.sh > ../plt/perf_actn_${TYPE}_${PER}_$SMH.lst
cd ../plt
ls -l perf_${TYPE}_${PER}_$SMH.lst
./perf_${TYPE}_${PER}_$SMH.plt
ls -l perf_${TYPE}_${PER}_$SMH.plt
#cp -p perf_${TYPE}_${PER}_$SMH.png ../www86/perf/perf_${TYPE}_${PER}_$SMH.png 

echo "`date`   $0: gestopt"
echo ""
echo ""
