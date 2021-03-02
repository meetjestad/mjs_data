# $Id: copy_04d_02w.sh $

cd `dirname $0`
HIER=`pwd`

[ ! -d tmp ] && mkdir tmp

for NAME04d in *_04d.plt
do
	NAME02w=`echo $NAME04d | sed "s/04d/02w/"`
	echo NAME02w=$NAME02w
	[ -f $NAME02w ] && {
	    echo $NAME02w bestaat al:
	    ls -l $NAME02w
	    DATUM="`ls --full-time $NAME02w | awk '{ print $6 }'`"
	    PDDC=`echo $DATUM | awk -F- '{ printf("%d%x%02d", $1%10, $2, $3) }' | tr abc ABC`
	    [ ! -f $NAME02w.$PDDC ] && {
	        cp -p $NAME02w $NAME02w.$PDDC
		ls -l $NAME02w.$PDDC
	    }
	    NAME02w=tmp/$NAME02w
	}

	cat $NAME04d | sed 's/04d/02w/g' | sed 's/%H\\n%d/     %d\\n     %b/' | sed 's/ 21600/ 86400/' > $NAME02w
	chmod +x $NAME02w

	diff $NAME04d $NAME02w

	echo ""
done
