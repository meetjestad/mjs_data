# $Id:$
# author: Peter dM

cd `dirname $0` 
for SH in ./run_pm_[0-9][0-9][0-9]_02m_[smh].sh
do
    [ -x $SH ] && ./$SH
done
