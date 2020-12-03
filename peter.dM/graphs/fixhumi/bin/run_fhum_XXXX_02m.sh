echo "$0 `date`: start"
echo ""

cd `dirname $0` 
HIER=`pwd`
IK=`basename $0 .sh`
PER=`echo $IK | awk -F_ '{ print $4 }'`
echo PER=$PER

SH=../../knmi/bin/run_knmi_thdrs_${PER}.sh
ls -l $SH
./$SH 
sleep 1
cd $HIER

for SH in run_fhum_????_${PER}.sh 
do
    [ `basename $SH .sh` != $IK ] && {
        [ -x $SH ] && {
	    #LST=../lst/`basename $SH .sh | sed 's/run/mjs/'`.lst
	    PLT=../plt/`basename $SH .sh | sed 's/run/mjs/'`.plt
	    PNG=../png/`basename $SH .sh | sed 's/run/mjs/'`.png
            ls -l $SH
            ./$SH
	    #ls -l $LST
	    ls -l $PLT
	    ls -l $PNG
            sleep 1
        }
    }
done

echo "$0 `date`: einde"

echo ""
echo ""
echo ""
echo ""
