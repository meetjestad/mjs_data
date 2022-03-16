import streamlit as st
import streamlit.components.v1 as components
import pandas as pd
from mjs_plots import mjs_plot
import datetime
import functools
import streamlit_parameters
import pydeck as pdk
from pydeck.types import String

import requests

st.set_page_config(layout="wide")

with st.container():
    st.title("Meet Je Stad Data Visualisatie")
    st.header(
        "Op deze pagina kan je experimenteren met de data van Meet Je Stad meetkastjes"
    )

plot_types = (
    "Line",
    "Scatter",
    "Histogram",
    "Bar",
    "3D Scatter",
)

sensor_ids = [
  "716", "717", "718", "719", "720", "721", "722", "723", "724", "725", "726", "727", "728", "729", "730", "733", "739", "740", "741", "742", "743", "744", "745", "746", "747", "748", "762", "763", "765", "766", "767", "768", "769", "770", "771", "772", "774", "775", "776", "777", "778", "779", "780", "781", "782", "873", "784", "785", "786", "787", "788", "789", "790", "791", "792", "793", "794", "795", "796", "832", "833", "834", "835", "838", "839", "840", "841", "842", "843", "864", "865", "866", "867", "868", "869", "870", "871", "872", "880", "881", "875", "877", "68", "2008", "2028",
]

# Register parameters to make sure the URL changes when an input value is updated.
parameters = streamlit_parameters.parameters.Parameters()

parameters.register_string_parameter(key="plot_type", default_value="Line")
parameters.register_string_list_parameter(key="sensor_ids", default_value="725")
parameters.register_string_list_parameter(key="extra_sensor_ids", default_value="")
parameters.register_string_list_parameter(key="knmi_ids", default_value=False)

parameters.register_date_parameter(
    key="start_date", default_value=datetime.datetime(2020, 1, 1)
)
parameters.register_date_parameter(
    key="end_date", default_value=datetime.datetime(2021, 12, 1)
)

# Streamlit input fields to interact with in the application.
chart_type = st.selectbox(
    label="Grafiek type",
    options=plot_types,
    index=plot_types.index(parameters.plot_type.value),
    key=parameters.plot_type.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state,
        key=parameters.plot_type.key,
    ),
)

sensors_input = st.multiselect(
    label="Meetkastje ids",
    options=sensor_ids,
    default=parameters.sensor_ids.default,
    key=parameters.sensor_ids.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state, key=parameters.sensor_ids.key
    ),
)

extra_sensor_ids_input = st.text_input(
    label="Of voer de ids handmatig in, scheid de waarden met een comma, bijv: 122,150",
    value=parameters.extra_sensor_ids.default,
    key=parameters.extra_sensor_ids.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state, key=parameters.extra_sensor_ids.key
    ),
)

knmi_input = st.checkbox(
    label="Data KNMI De Bilt toevoegen?",
    value=parameters.knmi_ids.default,
    key=parameters.knmi_ids.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state, key=parameters.knmi_ids.key
    ),
)

date_begin_input = st.date_input(
    "Startdatum",
    value=parameters.start_date.value,
    key=parameters.end_date.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state, key=parameters.end_date.key
    ),
)
date_end_input = st.date_input(
    "Einddatum",
    value=parameters.end_date.value,
    key=parameters.end_date.key,
    on_change=functools.partial(
        parameters.update_parameter_from_session_state, key=parameters.end_date.key
    ),
)

# Format the date input, to prepare it in the format the API call expects.
date_begin = date_begin_input.strftime("%Y-%m-%d, %H:%M")
date_end = date_end_input.strftime("%Y-%m-%d, %H:%M")

# Prepare sensor ids in the format the API calls expects it.
sensors = ",".join(sensors_input)
if (extra_sensor_ids_input != ""):
    sensors = sensors + "," + extra_sensor_ids_input

# Create link to API endpoint with the values given in the inputs.
link = f"https://meetjestad.net/data/?type=sensors&ids={sensors}&begin={date_begin}&end={date_end}&format=json"

def load_data():
    """
    Retrieves data from the Meet je Stad API and loads it as a Pandas DataFrame
    :return: Pandas DataFrame with measurement data
    """

    # The API returns all data (which is one entry each 15 minutes normally) for the given sensor ids in the time interval.
    r = requests.get(link)
    df = pd.DataFrame(r.json())

    # Retrieve the latest location for each measurement station. Used to plot on map.
    location_cols = ["id", "longitude", "latitude"]
    locationdf = df[df.columns.intersection(set(location_cols))]
    load_data.locationdf = locationdf.groupby(["id"], as_index=False).first()

    # If the user selected the option to show KNMI data, also add the KNMI station location.
    if (knmi_input): 
        knmi_stations = pd.DataFrame([["KNMI De Bilt", 5.180, 52.100]], columns=location_cols)
        load_data.locationdf = pd.concat([load_data.locationdf, knmi_stations])

    # Only keep columns that we need in the application.
    df = df[
        df.columns.intersection(
            set(["id", "timestamp", "temperature", "humidity", "pm2.5", "pm10"])
        )
    ]

    # Convert to Pandas datetime format for further computation.
    df["timestamp"] = pd.to_datetime(df["timestamp"])

    # For each sensor compute the minimum, maximum and mean values per day of each of the columns selected above.
    df = (
        df.groupby(["id", pd.Grouper(key="timestamp", freq="D")])
        .agg(["min", "max", "mean"])
        .round(2)
    )
    return df

def prepare_chart_data(df):
    """
    :param df: Pandas Dataframe with nested columns
    :return: Dataframe with flattened columns and correct data types
    """
    df.columns = [f"{i}_{j}" for i, j in df.columns]
    df = df.reset_index()
    df["timestamp"] = df["timestamp"].astype(str)
    df["id"] = df["id"].astype(str)
    return df

def add_knmi_data(df):
    """
    Retrieves data from the KNMI API with daily measurements values of their weather stations
    More info about the KNMI data here: https://www.knmi.nl/kennis-en-datacentrum/achtergrond/data-ophalen-vanuit-een-script
    And here https://www.daggegevens.knmi.nl/klimatologie/daggegevens
    :param df: Existing Pandas Dataframe with prepared measurement data of Meet je Stad sensors.
    :return: Dataframe with both the Meet je Stad data and KNMI data.
    """
    # Format input dates to what KNMI API expects.
    date_begin = date_begin_input.strftime("%Y%m%d")
    date_end = date_end_input.strftime("%Y%m%d")

    # Request data from API
    knmi_link = "https://www.daggegevens.knmi.nl/klimatologie/daggegevens"
    r = requests.post(knmi_link, data={'start': date_begin, 'end': date_end, 'vars': 'TEMP:MSTR', 'stns': '260', 'fmt': 'json'})
    knmi_df = pd.DataFrame(r.json())

    # Only select data from the measurement station in De Bilt (for now)
    knmi_df.loc[knmi_df.station_code == 260, 'id'] = "KNMI De Bilt"

    knmi_df["timestamp"] = knmi_df["date"].astype(str)

    # The mean (TG), minimum (TN) and maximum temperature (TX) are given in 0.1 degrees Celcius, converting it to whole degrees.
    knmi_df[["TG","TN", "TX"]] = knmi_df[["TG","TN", "TX"]].apply(lambda x: x/10)
    # Set the right column names.
    knmi_df = knmi_df.rename(columns={"TG": "temperature_mean", "TN": "temperature_min", "TX": "temperature_max", "UG": "humidity_mean", "UX": "humidity_max", "UN": "humidity_min"})
    # Remove unnecessary data which we retrieved from the API by selecting only the columns we need.
    knmi_df = knmi_df[
        knmi_df.columns.intersection(
            set(["id", "timestamp", "temperature_mean", "temperature_min", "temperature_max", "humidity_mean", "humidity_max", "humidity_min"])
        )
    ]
    # Merge existing data with KNMI data.
    return pd.concat([df, knmi_df])


# Kick off functions to retrieve Meet je Stad data and prepare it.
mjsdf = prepare_chart_data(load_data())

# Only retrieve and add KNMI data if the user selected this option in the UI.
if (knmi_input):
    mjsdf = add_knmi_data(mjsdf)

# Copy the Dataframe such that operations on it don't interfere with the original dataset.
copymjsdf = mjsdf.copy()

# Output plots
with st.container():
    plot = mjs_plot(chart_type, copymjsdf)
    parameters.set_url_fields()
    st.plotly_chart(plot, use_container_width=True)

# Convert id type to String.
load_data.locationdf["id"] = load_data.locationdf.id.apply(str)

# Helper function for the map with latest location data to automatically pan and zoom to fit the stations on the map on load.
computed_view = pdk.data_utils.compute_view(load_data.locationdf[["longitude", "latitude"]])

# This prevents zooming in too much if there is only one station on the map.
if (computed_view.zoom > 12):
    computed_view.zoom = 12

# Load a map with the latest locations of the measurement stations.
with st.container():
    st.pydeck_chart(
        pdk.Deck(
            map_style="mapbox://styles/mapbox/satellite-streets-v11",
            initial_view_state=computed_view,
            layers=[
                pdk.Layer(
                    "ScatterplotLayer",
                    data=load_data.locationdf,
                    get_position="[longitude, latitude]",
                    get_color="[200, 30, 0, 190]",
                    get_line_color="[0, 0, 0]",
                    stroked=True,
                    filled=True,
                    radius_min_pixels=30,
                    lineWidthMinPixels=4,
                    pickable=True,
                    extruded=True,
                ),
                pdk.Layer(
                    "TextLayer",
                    load_data.locationdf,
                    pickable=True,
                    get_position="[longitude, latitude]",
                    get_text="id",
                    get_size=25,
                    get_color=[256, 256, 256],
                    # Note that string constants in pydeck are explicitly passed as strings
                    # This distinguishes them from columns in a data set
                    get_text_anchor=String("middle"),
                    get_alignment_baseline=String("center"),
                ),
            ],
            tooltip={"html": "<b>Meetkastje: {id}</b>", "style": {"color": "white"}},
        )
    )

    # Idea to implement: Grow App
    # st.header("Grow App")
    # st.subheader("Draag bij door de GrowApp te downloaden.")
    # st.components.v1.iframe("https://www.growapp.today/embed/embed.html?tags=&bounds=4.960327148437501,52.032218104145315,5.280303955078125,52.133488040771496", height=500, scrolling=False)
    # https://growappdev.geodan.nl/api/photosets?fromUtc=2022-02-02T00:00:00&toUtc=2022-03-03T00:00:00

# Display the raw data we used for the plots.
st.subheader("Ruwe data")
copymjsdf
