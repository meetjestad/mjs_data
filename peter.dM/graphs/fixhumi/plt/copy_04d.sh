# $Id: copy_04d.sh $

cd `dirname $0`
HIER=`pwd`

[ ! -d tmp ] && mkdir tmp

for STID in $*
do
	NAME=`echo balc_fhum_0001_04d.plt | sed 's/balc_/mjs_/' | sed "s/0001/$STID/"`
	echo NAME=$NAME
	[ -f $NAME ] && {
	    echo $NAME bestaat al:
	    ls -l $NAME
	    DATUM="`ls --full-time $NAME | awk '{ print $6 }'`"
	    PDDC=`echo $DATUM | awk -F- '{ printf("%d%x%02d", $1%10, $2, $3) }' | tr abc ABC`
	    [ ! -f $NAME.$PDDC ] && {
	        cp -p $NAME $NAME.$PDDC
		ls -l $NAME.$PDDC
	    }
	    NAME=tmp/$NAME
	}

	cat balc_fhum_0001_04d.plt | sed 's/balc_/mjs_/' | sed "s/0001/$STID/" > $NAME
	chmod +x $NAME

	diff balc_fhum_0001_04d.plt $NAME

	echo ""
done
