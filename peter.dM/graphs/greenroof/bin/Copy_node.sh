[ -n "$*" ] &&  {
    NODES="$*"
} || {
    NODES="`ls ../index*html | sed 's/.*_//' | sed 's/.html//' | fgrep -v ../index`"
}
echo NODES=$NODES

for NODE in $NODES
do
        for PER in 02w 02m 06m 02y
        do
            [ -f run_greenroof_${NODE}_${PER}.sh ] && {
                echo -n "bestaat al:   "
                ls -l run_greenroof_${NODE}_${PER}.sh 
            } || {
                ln run_grndk_2031_${PER}.sh run_greenroof_${NODE}_${PER}.sh 
                ls -l run_greenroof_${NODE}_${PER}.sh 
            }
        done
done
