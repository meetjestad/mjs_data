for NODE in $*
do
        [ -f index_mjs20_${NODE}.html ] && {
            echo -n "bestaat al:   "
            ls -l index_mjs20_${NODE}.html 
        } || {
            cat index_mjs20_2002.html | sed "s/2002/${NODE}/" > index_mjs20_${NODE}.html 
            ls -l index_mjs20_${NODE}.html 
        }
done
