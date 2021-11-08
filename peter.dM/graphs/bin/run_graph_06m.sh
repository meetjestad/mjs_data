#!/bin/bash

# $Id:  web/meetjestad.net/public_html/static/graphs/bin/run_graph_06m.sh $

cd `dirname $0`
IK=`basename $0 .sh`
echo "`date`   $0 gestart"
echo ""
echo ""

../knmi/bin/run_knmi_thdrs_06m.sh      | tee    ../knmi/log/knmi_06m.log
../knmi/bin/run_knmi_thdrsN_06m.sh     | tee -a ../knmi/log/knmi_06m.log
../knmi/bin/run_knmi_thdrsT_06m.sh     | tee -a ../knmi/log/knmi_06m.log
../knmi/bin/run_knmi_thdrs_XXX_06m.sh  | tee -a ../knmi/log/knmi_06m.log

../batt/bin/run_batt_XXXX_06m.sh       | tee -a ../batt/log/batt_06m.log
#../bdp/bin/run_bdp_XXXX_06m.sh         | tee -a ../batt/log/bdp_06m.log
../bodem/bin/run_bodem_XXXX_06m.sh     | tee -a ../bodem/log/bodem_06m.log
../fixhumi/bin/run_7021_XXXX_06m.sh    | tee -a ../fixhumi/log/7021_06m.log
../fixhumi/bin/run_fhum_XXXX_06m.sh    | tee -a ../fixhumi/log/fhum_06m.log
../light/bin/run_light_XXXX_06m.sh     | tee -a ../light/log/light_06m.log
../mjs20/bin/run_mjs20_XXXX_06m.sh     | tee -a ../mjs20/log/mjs20_06m.log
../pm/bin/run_pm_XXX_06m.sh            | tee -a ../pm/log/mjs_pm_06m.log
../sens7021/bin/run_7021_XXXX_06m.sh   | tee -a ../sens7021/log/balc_7021_06m.log
#../senh7021/bin/run_7021n_XXXX_06m.sh  | tee -a ../senh7021/log/balc_7021n_06m.log
../se_th/bin/run_se_XXXX_06m.sh        | tee -a ../se_th/log/balc_se_06m.log

echo "`date`   $0 einde"
echo ""
echo ""
echo ""
echo ""

