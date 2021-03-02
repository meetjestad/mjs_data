for NODE in $*
do
        for PER in 02w 02m
        do
            [ -f run_batt_${NODE}_${PER}.sh ] && {
                echo -n "bestaat al:   "
                ls -l run_batt_${NODE}_${PER}.sh 
            } || {
                ln run_batt_2002_${PER}.sh run_batt_${NODE}_${PER}.sh 
                ls -l run_batt_${NODE}_${PER}.sh 
            }
        done
done
