# $Id: graphs/lmn/plt/Copy_node.sh $ 

# Copy plt file from node 10821 to other nodes

#NODES="`ls *plt | awk -F_ '{ print $3 }' | sort | uniq`"
[ -n "$*" ] &&  {
    NODES="$*"
    } || {
    NODES="`ls ../index*html | sed 's/.*_//' | sed 's/.html//' | fgrep -v ../index`"
}
echo NODES=$NODES
#[ -n "$*" ] && NODES="$*"

for NODE in $NODES
do
    [ "$NODE" != "10821" ] && {
        #for PER in 04d 02w 02m 06m 02y
        for PER in 04d 02w 02m 
        do
            [ ! -f lmn_pm_NL10821_${PER}.plt ] && {
                echo lmn_pm_NL10821_${PER}.plt ontbreekt
            }
            [ -f lmn_pm_NL10821_${PER}.plt ] && {
                [ ! -f lmn_pm_NL${NODE}_${PER}.plt ] && {
                    cat lmn_pm_NL10821_${PER}.plt | sed "s/10821/${NODE}/g" > lmn_pm_NL${NODE}_${PER}.plt 
                    chmod +x lmn_pm_NL${NODE}_${PER}.plt 
                    ls -l lmn_pm_NL${NODE}_${PER}.plt 
	        }
            }

            [ ! -f lmn_pm_NL10821_sc_${PER}.plt ] && {
                echo lmn_pm_NL10821_sc_${PER}.plt ontbreekt
            }
            [ -f lmn_pm_NL10821_sc_${PER}.plt ] && {
                [ ! -f lmn_pm_NL${NODE}_sc_${PER}.plt ] && {
                    cat lmn_pm_NL10821_sc_${PER}.plt | sed "s/10821/${NODE}/g" > lmn_pm_NL${NODE}_sc_${PER}.plt 
                    chmod +x lmn_pm_NL${NODE}_sc_${PER}.plt 
                    ls -l lmn_pm_NL${NODE}_sc_${PER}.plt 
	        }
            }
        done
    }
done

