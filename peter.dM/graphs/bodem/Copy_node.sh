for NODE in $*
do
    #[ -f index_bodem_${NODE}.html ] && {
        #echo -n "bestaat al:   "
        #ls -l index_bodem_${NODE}.html 
    #} || {
        #cat index_bodem_0754.html | sed "s/0754/${NODE}/" > index_bodem_${NODE}.html 
        #ls -l index_bodem_${NODE}.html 
    #}
               
    [ -f index_bodem_${NODE}.php ] && {
        echo -n "bestaat al:   "
        ls -l index_bodem_${NODE}.php 
    } || {
        cat index_bodem_2076.php | sed "s/2076/${NODE}/" > index_bodem_${NODE}.php 
        ls -l index_bodem_${NODE}.php 
    }
done
