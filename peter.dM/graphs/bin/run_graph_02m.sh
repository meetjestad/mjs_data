#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_02m.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

../knmi/bin/run_knmi_thdrs_02m.sh     | tee    ../knmi/log/knmi_02m.log
../knmi/bin/run_knmi_thdrsN_02m.sh    | tee -a ../knmi/log/knmi_02m.log
../knmi/bin/run_knmi_thdrsT_02m.sh    | tee -a ../knmi/log/knmi_02m.log

../batt/bin/run_batt_XXXX_02m.sh      | tee -a ../batt/log/batt_02m.log
../bodem/bin/run_bodem_XXXX_02m.sh    | tee -a ../bodem/log/bodem_02m.log
../fixhumi/bin/run_7021_XXXX_02m.sh   | tee -a ../fixhumi/log/7021_02m.log
../fixhumi/bin/run_fhum_XXXX_02m.sh   | tee -a ../fixhumi/log/fhum_02m.log
../light/bin/run_light_XXXX_02m.sh    | tee -a ../light/log/light_02m.log
../mjs20/bin/run_mjs20_XXXX_02m.sh    | tee -a ../mjs20/log/mjs20_02m.log
../pm/bin/run_pm_XXX_02m.sh           | tee -a ../pm/log/mjs_pm_02m.log
../sens7021/bin/run_7021_XXXX_02m.sh  | tee -a ../sens7021/log/balc_7021_02m.log
../senh7021/bin/run_7021n_XXXX_02m.sh | tee -a ../senh7021/log/balc_7021n_02m.log
../se_th/bin/run_se_XXXX_02m.sh       | tee -a ../se_th/log/balc_se_02m.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

