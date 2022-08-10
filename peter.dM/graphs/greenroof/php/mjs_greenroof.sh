cd `dirname $0`
IK=`basename $0 .sh`
#rm -f ../lst/*.lst
php $IK.php $*
#[ $? = 0 ] && {
    ls -ltr ../lst/*lst | tail -2
#}
