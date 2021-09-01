
import numpy as np
import pandas as pd
import seaborn as sns
import folium
import webbrowser
from folium.plugins import HeatMap

'''
url = r"https://earthquake.usgs.gov/fdsnws/event/1/query.csv";
url = url + "?starttime=1950-08-14%2000:00:00&endtime=2021-08-21%2023:59:59";
url = url + "&minmagnitude=7";
url = url + "&maxlatitude=-14.264&minlatitude=-60.065"
url = url + "&maxlongitude=-60.82&minlongitude=-82.617";
url = url + "&orderby=time";
posi = pd.read_csv(url)
num = len(posi);
lat = np.array(posi["latitude"][0:num])
lon = np.array(posi["longitude"][0:num])
mag = np.array(posi["mag"][0:num], dtype = float)
data1 = [[lat[i],lon[i],mag[i]] for i in range(num)]

# auto center to the middle of the lat/lon
clat = (np.min(lat) + np.max(lat)) / 2;
clon = (np.min(lon) + np.max(lon)) / 2;
map_osm = folium.Map(location = [clat,clon], tiles = 'Stamen Terrain', zoom_start = 4, control_scale = True)
HeatMap(data1).add_to(map_osm)

# Save as html file
file_path = r"test.html"
map_osm.save(file_path) 

# Open in default browser
webbrowser.open(file_path)
'''

import requests
import json
import math;


def remove(f):
  global lat, lon, temp;
  lat = lat[f];
  lon = lon[f];
  temp = temp[f];


tfrom = {'y': 2021, 'm': 8, 'd': 20, 'H': 0, 'M': 0};
tto = {'y': 2021, 'm': 8, 'd': 21, 'H': 0, 'M': 0};

url = 'https://meetjestad.net/data/?type=sensors&format=json';
url = url + '&begin=%d-%d-%d,%d:%d&end=%d-%d-%d,%d:%d' % (tfrom['y'], tfrom['m'], tfrom['d'], tfrom['H'], tfrom['M'], tto['y'], tto['m'], tto['d'], tto['H'], tto['M']);
print(url);

r = requests.get(url);
#print(r.text);

#jsonData = json.loads(r.text);
#num = len(jsonData);
#temp = np.array(jsonData["temperature"][0:num])
#temp

print('--');
pdata = pd.io.json.read_json(r.text);
print(pdata);
num = len(pdata);
print('--');
lat = np.array(pdata["latitude"][0:num]);
lon = np.array(pdata["longitude"][0:num]);
temp = np.array(pdata["temperature"][0:num]);
print(lat);

# Filter out items with NaN (undefined) values.
remove(np.logical_not(np.isnan(lat)));
remove(np.logical_not(np.isnan(lon)));
remove(np.logical_not(np.isnan(temp)));

# thuis (89) latitude 52.204, longitude 5.38129
# amersfoort lb 52.216983, 5.341343, ro 52.130576, 5.448526
remove(lon >= 5.28129);
remove(lon <= 5.48129);
remove(lat >= 52.104);
remove(lat <= 52.304);

data1 = [[lat[i],lon[i],temp[i]] for i in range(len(lat))];


# auto center to the middle of the lat/lon
clat = (np.min(lat) + np.max(lat)) / 2;
clon = (np.min(lon) + np.max(lon)) / 2;
print('center:', clat, clon);
map_osm = folium.Map(location = [clat,clon], tiles = 'Stamen Terrain', zoom_start = 13, control_scale = True)
HeatMap(data1).add_to(map_osm)

# Save as html file
file_path = r"test.html"
map_osm.save(file_path) 

# Open in default browser
webbrowser.open(file_path)




'''
https://meetjestad.net/data/?type=sensors&begin=2017-11-16,12:00&end=2017-11-16,12:15&format=json

https://meetjestad.net/data/?type=sensors&ids=2009&begin=2020-11-16,12:00&end=2021-08-28,23:59&format=json

'''




