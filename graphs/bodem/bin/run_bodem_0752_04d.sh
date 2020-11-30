echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
[ ! -d ../plt ] && mkdir ../plt

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo TYPE=$TYPE NODE=$NODE PER=$PER

php ../php/getbodem.php $NODE $PER
cd ../plt
ls -l mjs_${TYPE}_${NODE}_?_${PER}.lst
./mjs_${TYPE}_${NODE}_c_${PER}.plt
ls -l mjs_${TYPE}_${NODE}_c_${PER}.plt
./mjs_${TYPE}_${NODE}_t_${PER}.plt
ls -l mjs_${TYPE}_${NODE}_t_${PER}.plt

echo "`date`   $0: gestopt"
echo ""
echo ""
