-- aantal sensors met meting van luchtvochtigheid < 0. in de laatste 24 uur

SELECT DISTINCT station_id 
FROM sensors_measurement 
WHERE humidity < 0. 
AND timestamp > (SELECT MAX(timestamp) FROM sensors_measurement) - 86400 
ORDER BY station_id ASC;
