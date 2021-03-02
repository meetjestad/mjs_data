# $Id: run_mjs20_????_?_???.sh $
# Author: Peter Demmer for meetjestad

echo "`date`   $0: start"

cd `dirname $0`
HIER=`pwd`

IK=`basename $0 .sh`
TYPE=`echo $IK | awk -F_ '{ print $2 }'`
PHYS=`echo $IK | awk -F_ '{ print $3 }'`
G=`echo $IK | awk -F_ '{ print $4 }'`
PER=`echo $IK | awk -F_ '{ print $5 }'`
echo TYPE=$TYPE PHYS=$PHYS G=$G PER=$PER
case $G in
    1) NODES="2001 2003 2004 2005" ;;
    2) NODES="0567 2000 2002 2006 2007" ;;
esac

LINES=0
for NODE in $NODES
do
   LS="` ls -l ../lst/mjs_${TYPE}_${NODE}_${PER}.lst`"
   LNS="`echo $LS | awk '{ print $5 }'`"
   LINES=`expr $LINES + $LNS`
done

[ $LINES = 0 ] && {
    echo "../lst/mjs_${TYPE}_XXXX_${PER}.lst are empty; no plot"
} || {
    ls -l ../plt/mjs_${TYPE}_${PHYS}_${G}_${PER}.plt
    ../plt/mjs_${TYPE}_${PHYS}_${G}_${PER}.plt
    ls -l ../png/mjs_${TYPE}_${PHYS}_${G}_${PER}.png
}

echo "`date`   $0: gestopt"
echo ""
echo ""
