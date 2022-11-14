#for NODE in 0754 0517 0754 0661 0759 0758 0757 0417 0751 0203 0519 0756 0753 0752 0749
#for NODE in 2003 2059 2060 2061 2062 2063 2064 2065 2066 2068
#for NODE in 2021 2070 2076
for NODE in 2077 2078 2079 2080 2081 2082 2083 2084 2085
do
    for PER in 04d 02w 02m 06m
    do
        for T in m t
        do
            [ ! -f mjs_bodem_${NODE}_${T}_${PER}.plt ] && {
                cat mjs_bodem_2076_${T}_${PER}.plt | sed "s/2076/${NODE}/g" > mjs_bodem_${NODE}_${T}_${PER}.plt 
                chmod +x mjs_bodem_${NODE}_${T}_${PER}.plt 
                ls -l mjs_bodem_${NODE}_${T}_${PER}.plt 
            }
        done
    done
done

