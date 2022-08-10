# $Id: graphs/batt/bin/copy_node.sh $
# $Author: Peter Demmer $

cd `dirname $0`

[ -n "$*" ] &&  {
    NODES="$*"
} || {
    NODES="`ls ../index*html | sed 's/.*_//' | sed 's/.html//' | fgrep -v ../index`"
}
echo NODES=$NODES

for NODE in $NODES
do
    for PER in 02w 02m 06m
    do
        [ -f run_batt_${NODE}_${PER}.sh ] && {
            echo -n "bestaat al:   "
            ls -l run_batt_${NODE}_${PER}.sh 
        } || {
            ln run_batt_2002_${PER}.sh run_batt_${NODE}_${PER}.sh 
            ls -l run_batt_${NODE}_${PER}.sh 
        }
    done

    [ -f run_batt_${NODE}_XXX.sh ] && {
        echo -n "bestaat al:   "
        ls -l run_batt_${NODE}_XXX.sh 
    } || {
        ln run_batt_2002_XXX.sh run_batt_${NODE}_XXX.sh 
        ls -l run_batt_${NODE}_XXX.sh 
    }
done
