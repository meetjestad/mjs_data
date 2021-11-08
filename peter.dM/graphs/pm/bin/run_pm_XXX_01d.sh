# run_pm_XXX_01d.sh

cd `dirname $0` 
for SH in ./run_pm_[0-9][0-9][0-9]_01d.sh
do
    echo $SH:
    [ -x $SH ] && ./$SH | sed 's/^/    /'
    echo ""
done
echo ""
