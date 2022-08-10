for NODE in $*
do
        [ -f index_batt_${NODE}.html ] && {
            echo -n "bestaat al:   "
            ls -l index_batt_${NODE}.html 
        } || {
            cat index_batt_2002.html | sed "s/2002/${NODE}/" > index_batt_${NODE}.html 
            ls -l index_batt_${NODE}.html 
        }
done
