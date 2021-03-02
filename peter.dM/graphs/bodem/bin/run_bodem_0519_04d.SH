echo "`date`   $0: gestart"

cd `dirname $0`
HIER=`pwd`
#[ ! -d ../plt ] && mkdir ../plt

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
NODE=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo IK=$IK TYPE=$TYPE NODE=$NODE PER=$PER

php ../php/getbodem2.php $NODE $PER
ls -l ../lst/mjs_${TYPE}_${NODE}_c_${PER}.lst
ls -l ../plt/mjs_${TYPE}_${NODE}_c_${PER}.plt
../plt/mjs_${TYPE}_${NODE}_c_${PER}.plt
ls -l ../png/mjs_${TYPE}_${NODE}_c_${PER}.png

ls -l ../lst/mjs_${TYPE}_${NODE}_t_${PER}.lst
ls -l ../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
../plt/mjs_${TYPE}_${NODE}_t_${PER}.plt
ls -l ../png/mjs_${TYPE}_${NODE}_t_${PER}.png

echo "`date`   $0: gestopt"
echo ""
echo ""
