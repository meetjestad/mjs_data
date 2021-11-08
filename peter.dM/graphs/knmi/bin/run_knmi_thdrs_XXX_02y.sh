echo "`date`   $0: gestart"
ls -l $0 | sed 's/^/    /'
cd `dirname $0`
PER=`basename $0 .sh | awk -F_ '{ print $5 }'`
echo ""
#echo PER=$PER

for SH in run_knmi_thdrs_[0-9][0-9][0-9]_$PER.sh
do
    ls -l $SH | sed 's/^/    /'
    [ -x $SH ] && {
        ./$SH | sed 's/^/        /'
    }
    #echo ""
done
echo "`date`   $0: gestopt"
echo ""

