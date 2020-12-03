echo "gestart: `date`"
cd
FINDFILES="`find log -name 'sensors_recent.????-????.???' -mtime +0`"
AANTAL=`echo $FINDFILES | grep -v '^$' | wc -w`
[ -z "$FINDFILES" ] && {
    echo "find log -name 'sensors_recent.????-????.???' -mtime +0" is null
} || {
    echo "gzip $AANTAL logfiles: `date`"
    #ls -l $FINDFILES
    gzip $FINDFILES
}

FINDFILES="`find log -name 'sensors_recent.????-????.???.gz' -mtime +1`"
AANTAL=`echo $FINDFILES | grep -v '^$' | wc -w`
[ -z "$FINDFILES" ] && {
    echo "find log -name 'sensors_recent.????-????.???.gz' -mtime +1" is null
} || {
    echo "rm $AANTAL files: `date`"
    #ls -l $FINDFILES
    rm -f $FINDFILES
}

echo "gestopt: `date`"
echo ""
echo ""
