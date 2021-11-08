#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_04d.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""


../knmi/bin/run_knmi_thdrs_04d.sh      | tee    ../knmi/log/knmi_04d.log
../knmi/bin/run_knmi_thdrsN_04d.sh     | tee -a ../knmi/log/knmi_04d.log
../knmi/bin/run_knmi_thdrsT_04d.sh     | tee -a ../knmi/log/knmi_04d.log
../knmi/bin/run_knmi_thdrs_XXX_04d.sh  | tee -a ../knmi/log/knmi_04d.log

../batt/bin/run_batt_XXXX_04d.sh       | tee    ../batt/log/batt_04d.log
#../bdp/bin/run_bdp_XXXX_04d.sh         | tee    ../batt/log/bdp_04d.log
../bodem/bin/run_bodem_XXXX_04d.sh     | tee    ../bodem/log/bodem_04d.log
../fixhumi/bin/run_7021_XXXX_04d.sh    | tee    ../fixhumi/log/7021_04d.log
../fixhumi/bin/run_fhum_XXXX_04d.sh    | tee    ../fixhumi/log/fhum_04d.log
../light/bin/run_light_XXXX_04d.sh     | tee -a ../light/log/light_04d.log
../mjs20/bin/run_mjs20_XXXX_04d.sh     | tee    ../mjs20/log/mjs20_04d.log
../pm/bin/run_pm_XXX_04d.sh            | tee    ../pm/log/mjs_pm_04d.log
../sens7021/bin/run_7021_XXXX_04d.sh   | tee    ../sens7021/log/balc_7021_04d.log
../senh7021/bin/run_7021n_XXXX_04d.sh  | tee    ../senh7021/log/balc_7021n_04d.log
../se_th/bin/run_se_XXXX_04d.sh        | tee    ../se_th/log/balc_se_04d.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

