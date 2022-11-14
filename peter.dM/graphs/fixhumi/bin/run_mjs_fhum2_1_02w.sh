echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`
IK=`basename $0 .sh`
GROUP=`echo $IK | awk -F_ '{ print $3 }'`
N=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
echo "    IK=$IK GROUP=$GROUP N=$N PER=$PER"


PLT=../plt/mjs_${GROUP}_${N}_${PER}.plt
ls -l $PLT | sed 's/^/    /'
[ -x $PLT ] && $PLT
PNG="`echo $PLT | sed 's/plt/png/g'`"
ls -l $PNG | sed 's/^/    /'

echo "`date`   $0: einde"
echo ""
