cd `dirname $0`
IK="`basename $0 .sh`"
TYPE="`echo $IK | awk -F_ '{ print $2 }'`"
NODE="`echo $IK | awk -F_ '{ print $3 }'`"
[ -z "$NODE" ] && {
    echo "fout: geen nodenummer; abort"
    exit 1
}

for SH in run_${TYPE}_${NODE}_[0-9][0-9][dwmy].sh
do
    [ -x $SH ] &&  {
        echo $SH:
        ./$SH | sed 's/^/    /'
    }
done
