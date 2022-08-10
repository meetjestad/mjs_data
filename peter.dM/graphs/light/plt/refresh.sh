for PLT in *plt
do
    IK=`basename $PLT .plt`
    PNG=../png/$IK.png
    echo IK=$IK PLT=$PLT PNG=$PNG
    [ $PNG -ot $PLT ] && {
        ls -l $PLT
        ./$PLT
        ls -l $PNG
    }
done
