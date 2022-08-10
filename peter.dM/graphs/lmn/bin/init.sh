echo ./haal_lmn_pm.sh 2022-01-29T00:00:00+01:00.2022-02-01T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-25T00:00:00+01:00.2022-01-29T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-21T00:00:00+01:00.2022-01-25T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-17T00:00:00+01:00.2022-01-21T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-13T00:00:00+01:00.2022-01-17T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-09T00:00:00+01:00.2022-01-13T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-05T00:00:00+01:00.2022-01-09T00:00:00+01:00
echo ./haal_lmn_pm.sh 2022-01-01T00:00:00+01:00.2022-01-05T00:00:00+01:00

for YEAR in 2021
do
	for MO in 12 11 10 09 08 07 06 05 04 03 02 01
	do
		MO1=`echo $MO | awk '{ printf("%02d", ($1 % 12) + 1) }'`
		echo "# YEAR=$YEAR MO=$MO MO1=$MO1"

		echo ./haal_lmn_pm.sh ${YEAR}-${MO}-29T00:00:00+00:00.${YEAR}-${MO1}-01T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-25T00:00:00+00:00.${YEAR}-${MO}-29T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-21T00:00:00+00:00.${YEAR}-${MO}-25T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-17T00:00:00+00:00.${YEAR}-${MO}-21T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-13T00:00:00+00:00.${YEAR}-${MO}-17T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-09T00:00:00+00:00.${YEAR}-${MO}-13T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-05T00:00:00+00:00.${YEAR}-${MO}-09T00:00:00+00:00
		echo sleep 3
                echo ./haal_lmn_pm.sh ${YEAR}-${MO}-01T00:00:00+00:00.${YEAR}-${MO}-05T00:00:00+00:00
		echo sleep 3
	done
done

exit


