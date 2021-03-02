from datetime import datetime
from datetime import timedelta

with open("fijnstof-oudjaar.csv") as fIn998:
    lst998 = fIn998.readlines()
    
fUit = open("mjs_pm_998_02d_0101.lst", "w")

for iRgl in range (1,len(lst998)):
    lst998[iRgl] = lst998[iRgl].strip()
    flds998 = lst998[iRgl].split(';')
    len998 = len(flds998)
    #print ("%d: %s" % (leng, lst998[iRgl]))
    if len998 == 20:
        humi = float(flds998[13])
        temp = float(flds998[14])
        pm10 = float(flds998[15])
        pm25 = float(flds998[16])
        pm01 = float(flds998[17])
        datumtijd = flds998[18]
        datum = flds998[18].split(' ')[0]
        tijd = flds998[18].split(' ')[1]
        jaar = int(datum.split('/')[2])
        maand = int(datum.split('/')[0])
        dag = int(datum.split('/')[1])
        uur = 99
        mnt = 99
        tno = len(tijd.split(':'))
        if tno > 1:
           uur = int(tijd.split(":")[0])
           mnt = int(tijd.split(":")[1])
        #print("pm10=%s pm25=%s pm01=%s jaar=%s maand=%s dag=%s uur=%s mnt=%s" % (pm10, pm25, pm01, jaar, maand, dag, uur, mnt))
        datumtijd2 = "%04d-%02d-%02d %02d:%02d:00" % (jaar, maand, dag, uur, mnt)
        datumtijd3 = datetime.strptime(datumtijd2, '%Y-%m-%d %H:%M:%S')
        datumtijd4 = datumtijd3 + timedelta(hours=1)
        #uit1 = datumtijd3.strftime('%Y-%m-%d.%H:%M:%S') + "   "
        uit1 = datumtijd4.strftime('%Y-%m-%d.%H:%M:%S') + "   %6.2f   %6.2f   %6.2f   %6.2f   %6.2f" % (temp, humi, pm01, pm25, pm10)
        #print(uit1)
        fUit.write(uit1 + "\n")

fUit.close()

