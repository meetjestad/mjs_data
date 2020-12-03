cd `dirname $0` 
for SH in ./run_pm_[0-9][0-9][0-9]_01d.sh
do
    [ -x $SH ] && ./$SH
done
