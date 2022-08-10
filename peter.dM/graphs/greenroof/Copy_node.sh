for NODE in $*
do
        [ -f index_greenroof_${NODE}.php ] && {
            echo -n "bestaat al:   "
            ls -l index_greenroof_${NODE}.php 
        } || {
            cat index_greenroof_2031.php | sed "s/2031/${NODE}/" > index_greenroof_${NODE}.php 
            ls -l index_greenroof_${NODE}.php 
        }
done
