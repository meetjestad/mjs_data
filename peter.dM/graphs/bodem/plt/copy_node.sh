for NODE in 0754 0517 0754 0761 0759 0758 0757 0417 0751 0203 0519 0756 0753 0752 0749
do
    for PER in 04d 02w 02m 
    do
        for T in c t
        do
            [ ! -f mjs_bodem_${NODE}_${T}_${PER}.plt ] && {
                cat mjs_bodem_0661_${T}_${PER}.plt | sed "s/0661/${NODE}/g" > mjs_bodem_${NODE}_${T}_${PER}.plt 
                chmod +x mjs_bodem_${NODE}_${T}_${PER}.plt 
                ls -l mjs_bodem_${NODE}_${T}_${PER}.plt 
            }
        done
    done
done

