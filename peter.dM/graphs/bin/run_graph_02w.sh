#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_02w.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

../knmi/bin/run_knmi_thdrs_02w.sh      | tee    ../knmi/log/knmi_02w.log
../knmi/bin/run_knmi_thdrsN_02w.sh     | tee -a ../knmi/log/knmi_02w.log
../knmi/bin/run_knmi_thdrsT_02w.sh     | tee -a ../knmi/log/knmi_02w.log
../knmi/bin/run_knmi_thdrs_XXX_02w.sh  | tee -a ../knmi/log/knmi_02w.log

../batt/bin/run_batt_XXXX_02w.sh       | tee    ../batt/log/batt_02w.log
#../bdp/bin/run_bdp_XXXX_02w.sh         | tee    ../batt/log/bdp_02w.log
../bodem/bin/run_bodem_XXXX_02w.sh     | tee    ../bodem/log/bodem_02w.log
../fixhumi/bin/run_7021_XXXX_02w.sh    | tee    ../fixhumi/log/7021_02w.log
../fixhumi/bin/run_fhum_XXXX_02w.sh    | tee    ../fixhumi/log/fhum_02w.log
../light/bin/run_light_XXXX_02w.sh     | tee    ../light/log/light_02w.log
../mjs20/bin/run_mjs20_XXXX_02w.sh     | tee    ../mjs20/log/mjs20_02w.log
../pm/bin/run_pm_XXX_02w.sh            | tee    ../pm/log/mjs_pm_02w.log
../sens7021/bin/run_7021_XXXX_02w.sh   | tee    ../sens7021/log/balc_7021_02w.log
../senh7021/bin/run_7021n_XXXX_02w.sh  | tee    ../senh7021/log/balc_7021n_02w.log
../se_th/bin/run_se_XXXX_02w.sh        | tee    ../se_th/log/balc_se_02w.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

