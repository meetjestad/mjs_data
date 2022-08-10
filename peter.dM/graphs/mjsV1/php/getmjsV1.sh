cd `dirname $0`
#rm -f ../lst/*.lst
php getmjsV1.php $*
#[ $? = 0 ] && {
    ls -ltr ../lst/*lst | tail -3
#}
