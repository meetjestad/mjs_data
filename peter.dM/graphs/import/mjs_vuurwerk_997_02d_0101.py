with open("PM2.5.csv") as f25:
    l25 = f25.readlines()
    
with open("PM10.csv") as f10:
    l10 = f10.readlines()

fUit = open("mjs_pm_997_02d_0101.lst", "w")

for iRgl in range (2,len(l25)):
    l25[iRgl] = l25[iRgl].strip()
    l25[iRgl] = l25[iRgl].replace('"', '')
    l25[iRgl] = l25[iRgl].replace(' ', ';')
    fields25 = l25[iRgl].split(',')
    l10[iRgl] = l10[iRgl].strip()
    l10[iRgl] = l10[iRgl].replace('"', '')
    l10[iRgl] = l10[iRgl].replace(' ', ';')
    fields10 = l10[iRgl].split(',')
    if len(fields25) == 3:
        uit = fields25[1] + ':00;' + fields25[2] + ',0;'
    if len(fields25) == 4:
        uit = fields25[1] + ':00;' + fields25[2] + ',' + fields25[3] + ';'
    if len(fields10) == 3:
        uit += fields10[1] + ':00;' + fields10[2] + ',0'
    if len(fields10) == 4:
        uit += fields10[1] + ':00;' + fields10[2] + ',' + fields10[3]
    #print(uit)
    datum=uit.split(';')[0]
    tijd=uit.split(';')[1]
    pm25=float(uit.split(';')[2].replace(',', '.'))
    pm10=float(uit.split(';')[5].replace(',', '.'))
    jaar=datum.split('-')[2]
    maand=datum.split('-')[1]
    dag=datum.split('-')[0]
    buf = "20%s-%s-%s.%s   %6.2f   %6.2f" % (jaar, maand, dag, tijd, pm25, pm10)
    #print(buf)
    fUit.write(buf + "\n")

fUit.close()

