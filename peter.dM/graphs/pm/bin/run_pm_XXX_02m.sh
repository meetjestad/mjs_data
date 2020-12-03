cd `dirname $0` 
for SH in ./run_pm_[0-9][0-9][0-9]_02m.sh
do
    [ -x $SH ] && ./$SH
done
