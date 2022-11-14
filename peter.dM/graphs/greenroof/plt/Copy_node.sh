# $Id: graphs/greenroof/plt/Copy_node.sh $ 

# Copy plt script from node 2086 to 1 or more others

[ -n "$*" ] &&  {
    NODES="$*"
    } || {
    NODES="`ls ../index*html | sed 's/.*_//' | sed 's/.html//' | fgrep -v ../index`"
}
echo NODES=$NODES

for NODE in $NODES
do
    [ "$NODE" != "2086" ] && {
        for PER in 02w 02m 06m 02y
        do
            for TY in te hu
            do
                [ ! -f mjs_greenroof_2086_${TY}_${PER}.plt ] && {
                    echo mjs_greenroof_2086_${TY}_${PER}.plt ontbreekt
                }
                [ -f mjs_greenroof_2086_${TY}_${PER}.plt ] && {
                    [ ! -f mjs_greenroof_${NODE}_${TY}_${PER}.plt ] && {
                        cat mjs_greenroof_2086_${TY}_${PER}.plt | sed "s/2086/${NODE}/g" > mjs_greenroof_${NODE}_${TY}_${PER}.plt 
                        chmod +x mjs_greenroof_${NODE}_${TY}_${PER}.plt 
                        ls -l mjs_greenroof_${NODE}_${TY}_${PER}.plt 
                    }
                }
            done
        done
    }
done

