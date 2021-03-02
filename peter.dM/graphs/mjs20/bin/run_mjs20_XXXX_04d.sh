	echo "$0 `date`: start"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`

[ ! -d ../lst ] && mkdir ../lst
[ ! -d ../plt ] && mkdir ../plt
[ ! -d ../plt ] && mkdir ../png

#SH=../../knmi/bin/run_knmi_thdrs_04d.sh
#ls -l $SH
#./$SH 
#sleep 1
#cd $HIER

for SH in run_mjs20_????_04d.sh run_mjs20_????_?_04d.sh
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
            ls -l $SH | sed 's/^/    /'
            ./$SH | sed 's/^/    /'
            sleep 2
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
