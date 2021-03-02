# $Id: graphs/batt/plt/copy_node.sh $ 

# Copy plt file from node 2002 to 1 or more others

for NODE in $*
do
    [ "$NODE" != "2002" ] && {
        for PER in 02w 02m
        do
            [ ! -f mjs_batt_2002_${PER}.plt ] && {
                echo mjs_batt_2002_${PER}.plt ontbreekt
            }
            [ -f mjs_batt_2002_${PER}.plt ] && {
                [ -f mjs_batt_${NODE}_${PER}.plt ] && {
                    echo -n "bestaat al:   "
                    ls -l mjs_batt_${NODE}_${PER}.plt
                } 
                [ ! -f mjs_batt_${NODE}_${PER}.plt ] && {
                    cat mjs_batt_2002_${PER}.plt | sed "s/2002/${NODE}/g" > mjs_batt_${NODE}_${PER}.plt 
                    chmod +x mjs_batt_${NODE}_${PER}.plt 
                    ls -l mjs_batt_${NODE}_${PER}.plt 
	        }
            }
        done
    }
done

