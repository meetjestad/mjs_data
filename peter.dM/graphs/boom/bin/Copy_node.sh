for NODE in 0000
do
    for PER in 04d 02w 02m 
    do
        [ ! -f run_bodem_${NODE}_${PER}.sh ] && {
            cp -p run_bodem_0081_${PER}.sh run_bodem_${NODE}_${PER}.sh 
            ls -l run_bodem_${NODE}_${PER}.sh 
        }
    done
done

