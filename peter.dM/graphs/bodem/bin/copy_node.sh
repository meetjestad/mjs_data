# run_bodem_0519_04d.sh

for NODE in 0517 0519 0753 0754 0756 0757 0761
do
    for PER in 04d 02w 02m
    do
        [ ! -f zz_archief/run_bodem_${NODE}_${PER}.sh ] && {
            mv run_bodem_${NODE}_${PER}.sh zz_archief
        }
	ln run_bodem_0661_${PER}.sh run_bodem_${NODE}_${PER}.sh
	ls -l run_bodem_${NODE}_${PER}.sh
    done
done

