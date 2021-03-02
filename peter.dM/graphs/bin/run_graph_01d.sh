#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_01d.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""


#9,24,39,54 * * * *	web/meetjestad.net/public_html/static/graphs/pm/bin/run_pm_XXX_01d.sh >> web/meetjestad.net/public_html/static/graphs/pm/log/mjs_pm_01d.log
#9,24,39,54 * * * *	web/meetjestad.net/public_html/static/graphs/sens7021/bin/run_7021_XXXX_01d.sh >> web/meetjestad.net/public_html/static/graphs/sens7021/log/balc_7021_01d.log
#9,24,39,54 * * * *	web/meetjestad.net/public_html/static/graphs/se_th/bin/run_se_XXXX_01d.sh >> web/meetjestad.net/public_html/static/graphs/se_th/log/balc_se_01d.log

../knmi/bin/run_knmi_thdrs_01d.sh     | tee    ../knmi/log/knmi_01d.log
../knmi/bin/run_knmi_thdrsN_01d.sh    | tee -a ../knmi/log/knmi_01d.log
../knmi/bin/run_knmi_thdrsT_01d.sh    | tee -a ../knmi/log/knmi_01d.log

../batt/bin/run_batt_XXXX_01d.sh      | tee -a ../batt/log/mjs_batt_01d.log
../light/bin/run_light_XXXX_01d.sh    | tee -a ../light/log/mjs_light_01d.log
../pm/bin/run_pm_XXX_01d.sh           | tee    ../pm/log/mjs_pm_01d.log
../sens7021/bin/run_7021_XXXX_01d.sh  | tee -a ../sens7021/log/balc_7021_01d.log
../senh7021/bin/run_7021n_XXXX_01d.sh | tee -a ../senh7021/log/balc_7021n_01d.log
../se_th/bin/run_se_XXXX_01d.sh       | tee -a ../se_th/log/balc_se_01d.log


echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

