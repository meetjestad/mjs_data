# $Id:$
# author: Peter-dM

cd `dirname $0` 
for SH in ./run_pm_[0-9][0-9][0-9]_01d_[smh].sh
do
    echo $SH:
    [ -x $SH ] && ./$SH | sed 's/^/    /'
done
