cd `dirname $0`
for PLT in `ls -t *.plt`
do
    [ -x $PLT ] && {
        PNG=`basename $PLT .plt`.png
        #[ ../png/$PNG -ot $PLT ] && {
            NODE=`echo $PLT | awk -F_ '{ print $3 }'`
            PER=`basename $PLT .plt | awk -F_ '{ print $5 }'`
            echo NODE=$NODE PER=$PER PNG=$PNG
            ls -l $PLT
            SH=../bin/run_boom_${NODE}_${PER}.sh
            [ -x $SH ] && {
                #echo $SH:
                $SH | sed 's/^/    /'
                ls -l ../png/$PNG
            }
        #}
    }
done
