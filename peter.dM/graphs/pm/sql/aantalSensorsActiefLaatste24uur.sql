-- aantal sensors actief in de laatste 24 uur

SELECT DISTINCT station_id 
FROM sensors_measurement 
WHERE timestamp > (SELECT MAX(timestamp) FROM sensors_measurement) - 86400 
ORDER BY timestamp ASC;

