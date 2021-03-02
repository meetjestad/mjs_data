< set xtics 604800
< set mxtics 7
---
> set xtics 86400
> set mxtics 4


# $Id: copy_04d_02m.sh $

cd `dirname $0`
HIER=`pwd`

[ ! -d tmp ] && mkdir tmp

for NAME04d in *_04d.plt
do
	NAME02m=`echo $NAME04d | sed "s/04d/02m/"`
	echo NAME02m=$NAME02m
	[ -f $NAME02m ] && {
	    echo $NAME02m bestaat al:
	    ls -l $NAME02m
	    DATUM="`ls --full-time $NAME02m | awk '{ print $6 }'`"
	    PDDC=`echo $DATUM | awk -F- '{ printf("%d%x%02d", $1%10, $2, $3) }' | tr abc ABC`
	    [ ! -f $NAME02m.$PDDC ] && {
	        cp -p $NAME02m $NAME02m.$PDDC
		ls -l $NAME02m.$PDDC
	    }
	    NAME02m=tmp/$NAME02m
	}

	cat $NAME04d | sed 's/04d/02m/g' | sed 's/%H\\n%d/     %d\\n     %b/' | sed 's/ 21600/ 604800/' | sed 's/mxtics 4/mxtics 7/' > $NAME02m
	chmod +x $NAME02m

	diff $NAME04d $NAME02m

	echo ""
done
