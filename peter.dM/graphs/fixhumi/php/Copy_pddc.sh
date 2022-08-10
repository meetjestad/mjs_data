# $Id: Copy_pddc.sh $
# $Author: Peter Demmer $

cd `dirname $0`
HIER=`pwd`

for FILE in $*
do
    [ -f $FILE ] && {
        DATUM="`ls --full-time $FILE | awk '{ print $6 }'`"
        PDDC=`echo $DATUM | awk -F- '{ printf("%d%x%02d", $1%10, $2, $3) }' | tr abc ABC`
        [ ! -f $FILE.$PDDC ] && {
            cp -p $FILE $FILE.$PDDC
	    ls -l $FILE.$PDDC
        }
    }
done
