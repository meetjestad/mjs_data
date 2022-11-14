for PLT in *plt
do
    IK=`basename $PLT .plt`
    PNG=../png/$IK.png
    #echo $IK
    [ $PNG -ot $PLT ] && {
        ls -l $PLT
        ./$PLT
        ls -l $PNG
    }
done
