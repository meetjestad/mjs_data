# run_bodem_0756_02m.sh
# run_bodem_0756_02w.sh
# run_bodem_0756_04d.sh

for NODE in 0417 0757 0758 0759 0761 
do
    for PER in 04d 02w 02m 
    do
        [ ! -f run_bodem_${NODE}_${PER}.sh ] && {
            cp -p run_bodem_0756_${PER}.sh run_bodem_${NODE}_${PER}.sh 
            ls -l run_bodem_${NODE}_${PER}.sh 
        }
    done
done

