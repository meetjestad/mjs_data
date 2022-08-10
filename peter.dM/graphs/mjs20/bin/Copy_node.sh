for NODE in $*
do
        for PER in  04d 02w 02m
        do
            [ -f run_mjs20_${NODE}_${PER}.sh ] && {
                echo -n "bestaat al:   "
                ls -l run_mjs20_${NODE}_${PER}.sh 
            } || {
                ln run_mjs20_2002_${PER}.sh run_mjs20_${NODE}_${PER}.sh 
		#chmod +x run_mjs20_${NODE}_${PER}.sh
                ls -l run_mjs20_${NODE}_${PER}.sh 
            }
        done
done
