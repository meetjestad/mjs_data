# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_04d.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

#8,23,38,53 * * * *	web/meetjestad.net/public_html/static/graphs/bodem/bin/run_bodem_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/bodem/log/bodem_04d.log
#8,23,38,53 * * * *	web/meetjestad.net/public_html/static/graphs/fixhumi/bin/run_7021_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/fixhumi/log/fhum_04d.log
#8,23,38,53 * * * *	web/meetjestad.net/public_html/static/graphs/fixhumi/bin/run_fhum_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/fixhumi/log/fhum_04d.log
#8,23,38,53 * * * *	web/meetjestad.net/public_html/static/graphs/mjs20/bin/run_mjs20_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/mjs20/log/mjs20_04d.log
#10,25,40,55 * * * *	web/meetjestad.net/public_html/static/graphs/pm/bin/run_pm_XXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/pm/log/mjs_pm_04d.log
#10,25,40,55 * * * *	web/meetjestad.net/public_html/static/graphs/se_th/bin/run_se_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/se_th/log/balc_se_04d.log
#10,25,40,55 * * * *	web/meetjestad.net/public_html/static/graphs/sens7021/bin/run_7021_XXXX_04d.sh >> web/meetjestad.net/public_html/static/graphs/sens7021/log/balc_7021_04d.log

../knmi/bin/run_knmi_thdrs_04d.sh     | tee -a ../knmi/log/knmi_04d.log

../bodem/bin/run_bodem_XXXX_04d.sh    | tee -a ../bodem/log/bodem_04d.log
../fixhumi/bin/run_7021_XXXX_04d.sh   | tee -a ../fixhumi/log/7021_04d.log
../fixhumi/bin/run_fhum_XXXX_04d.sh   | tee -a ../fixhumi/log/fhum_04d.log
../mjs20/bin/run_mjs20_XXXX_04d.sh    | tee -a ../mjs20/log/mjs20_04d.log
../pm/bin/run_pm_XXX_04d.sh           | tee -a ../pm/log/mjs_pm_04d.log
../sens7021/bin/run_7021_XXXX_04d.sh  | tee -a ../sens7021/log/balc_7021_04d.log
../se_th/bin/run_se_XXXX_04d.sh       | tee -a ../se_th/log/balc_se_04d.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

