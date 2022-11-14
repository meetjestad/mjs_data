echo `date` $0: gestart
cd `dirname $0` 
IK=`basename $0 .sh`
GROUP=`echo $IK | awk -F_ '{ print $3 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
echo GROUP=$GROUP PER=$PER 

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../png ] && mkdir ../png

for SH in run_mjs_${GROUP}_[0-9]_${PER}.sh
do
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done

for PLT in ../plt/mjs_${GROUP}_?_${PER}.plt
do
    ls -l $PLT | sed 's/^/    /'
    [ -x $PLT ] && $PLT
    PNG="`echo $PLT | sed 's/plt/png/g'`"
    ls -l $PNG | sed 's/^/    /'
done

echo `date` $0: einde
echo ""
echo ""

