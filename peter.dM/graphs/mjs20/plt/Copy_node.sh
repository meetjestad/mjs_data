NODES="0567 2000 2001 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2020 2021 2022 2023 2024 2025 2026 2027"
[ -n "$*" ] && NODES="$*"

for NODE in $NODES
do
    for TY in th pm 
    do
        for PER in  04d 02w 02m
        do
            [ -f mjs_mjs20_${NODE}_${TY}_${PER}.plt ] && {
                echo -n "bestaat al:   "
                ls -l mjs_mjs20_${NODE}_${TY}_${PER}.plt 
            } || {
                cat mjs_mjs20_2002_${TY}_${PER}.plt | sed "s/2002/${NODE}/" > mjs_mjs20_${NODE}_${TY}_${PER}.plt 
		chmod +x mjs_mjs20_${NODE}_${TY}_${PER}.plt
                ls -l mjs_mjs20_${NODE}_${TY}_${PER}.plt 
            }
        done
    done
done
