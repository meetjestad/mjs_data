[ -r meetjestad_test.env ] || {
    echo "meetjestad_test.env ontbreekt; abort"
    exit 1
}
. meetjestad_test.env

echo "mysqldump --compact --single-transaction -B $DBASE --no-data -h localhost -u$DBUSER -p$DBPASS | sed -f backup.sed > $DBASE.model.sql"
mysqldump --compact --single-transaction -B $DBASE --no-data -h localhost -u$DBUSER -p$DBPASS | sed -f backup.sed > $DBASE.model.sql
ls -l $DBASE.model.sql
