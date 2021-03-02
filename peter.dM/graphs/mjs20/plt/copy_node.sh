for NODE in $*
do
    for TY in th pm 
    do
        for PER in  04d 02w 02m
        do
            [ -f mjs_mjs20_${NODE}_${TY}_${PER}.plt ] && {
                echo -n "bestaat al:   "
                ls -l mjs_mjs20_${NODE}_${TY}_${PER}.plt 
            } || {
                cat mjs_mjs20_2002_${TY}_${PER}.plt | sed "s/2002/${NODE}/" > mjs_mjs20_${NODE}_${TY}_${PER}.plt 
		chmod +x mjs_mjs20_${NODE}_${TY}_${PER}.plt
                ls -l mjs_mjs20_${NODE}_${TY}_${PER}.plt 
            }
        done
    done
done
