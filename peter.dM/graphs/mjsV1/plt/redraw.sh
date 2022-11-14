cd `dirname $0`

for PLT in `ls -tr *.plt`
do
    [ -x $PLT ] && {
        PNG=`basename $PLT .plt`.png
        ls -l $PLT
	./$PLT
	ls -l ../png/$PNG
    }
done
