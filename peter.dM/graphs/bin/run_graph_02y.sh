#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_02y.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

../knmi/bin/run_knmi_thdrs_02y.sh      | tee    ../knmi/log/knmi_02y.log
../knmi/bin/run_knmi_thdrsN_02y.sh     | tee -a ../knmi/log/knmi_02y.log
../knmi/bin/run_knmi_thdrsT_02y.sh     | tee -a ../knmi/log/knmi_02y.log
../knmi/bin/run_knmi_thdrs_XXX_02y.sh  | tee -a ../knmi/log/knmi_02y.log

../batt/bin/run_batt_XXXX_02y.sh       | tee -a ../batt/log/batt_02y.log
#../bdp/bin/run_bdp_XXXX_02y.sh         | tee -a ../batt/log/bdp_02y.log
#../bodem/bin/run_bodem_XXXX_02y.sh     | tee -a ../bodem/log/bodem_02y.log
#../fixhumi/bin/run_7021_XXXX_02y.sh    | tee -a ../fixhumi/log/7021_02y.log
#../fixhumi/bin/run_fhum_XXXX_02y.sh    | tee -a ../fixhumi/log/fhum_02y.log
#../light/bin/run_light_XXXX_02y.sh     | tee -a ../light/log/light_02y.log
#../mjs20/bin/run_mjs20_XXXX_02y.sh     | tee -a ../mjs20/log/mjs20_02y.log
#../pm/bin/run_pm_XXX_02y.sh            | tee -a ../pm/log/mjs_pm_02y.log
#../sens7021/bin/run_7021_XXXX_02y.sh   | tee -a ../sens7021/log/balc_7021_02y.log
#../senh7021/bin/run_7021n_XXXX_02y.sh  | tee -a ../senh7021/log/balc_7021n_02y.log
#../se_th/bin/run_se_XXXX_02y.sh        | tee -a ../se_th/log/balc_se_02y.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

