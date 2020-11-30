# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_02w.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

../knmi/bin/run_knmi_thdrs_02w.sh     | tee -a ../knmi/log/knmi_02w.log

../batt/bin/run_batt_XXXX_02w.sh      | tee -a ../batt/log/batt_02w.log
../bodem/bin/run_bodem_XXXX_02w.sh    | tee -a ../bodem/log/bodem_02w.log
../fixhumi/bin/run_7021_XXXX_02w.sh   | tee -a ../fixhumi/log/7021_02w.log
../fixhumi/bin/run_fhum_XXXX_02w.sh   | tee -a ../fixhumi/log/fhum_02w.log
../mjs20/bin/run_mjs20_XXXX_02w.sh    | tee -a ../mjs20/log/mjs20_02w.log
../pm/bin/run_pm_XXX_02w.sh           | tee -a ../pm/log/mjs_pm_02w.log
../sens7021/bin/run_7021_XXXX_02w.sh  | tee -a ../sens7021/log/balc_7021_02w.log
../se_th/bin/run_se_XXXX_02w.sh       | tee -a ../se_th/log/balc_se_02w.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

