for PLT in `find . -name '*.plt' | grep -v zz_archief`
do
    [ -x $PLT ] && {
        PNG=`basename $PLT .plt`.png
	NODE=`echo $PLT | awk -F_ '{ print $3 }'`
	PER=`basename $PLT .plt | awk -F_ '{ print $5 }'`
	#echo NODE=$NODE PER=$PER
        ls -l $PLT
	echo ../bin/run_mjsV1_${NODE}_${PER}.sh
	../bin/run_mjsV1_${NODE}_${PER}.sh
	ls -l ../png/$PNG
    }
done
