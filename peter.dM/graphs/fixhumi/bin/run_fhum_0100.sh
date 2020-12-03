cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
NODE=`echo $IK | awk -F_ '{ printf("%04d", $3) }'`

./run_fhum_${NODE}_04d.sh
./run_fhum_${NODE}_02w.sh
./run_fhum_${NODE}_02m.sh
./run_fhum_${NODE}_06m.sh
./run_fhum_${NODE}_02y.sh
