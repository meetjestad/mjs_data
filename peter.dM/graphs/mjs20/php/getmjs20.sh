cd `dirname $0`
#rm -f ../lst/*.lst
php getmjs20.php $*
#[ $? = 0 ] && {
    ls -ltr ../lst/*lst | tail -3
#}
