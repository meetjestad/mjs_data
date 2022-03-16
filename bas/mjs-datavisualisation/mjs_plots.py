import plotly.express as px
import streamlit as st
import functools

import streamlit_parameters

data_fields = [
    "id",
    "timestamp",
    "temperature_min",
    "temperature_max",
    "temperature_mean",
    "humidity_min",
    "humidity_max",
    "humidity_mean",
    "pm2.5_min",
    "pm2.5_max",
    "pm2.5_mean",
    "pm10_min",
    "pm10_max",
    "pm10_mean"
]

def show_x_axis(parameters):
    return st.selectbox(
            label="x-as",
            options=data_fields,
            index=data_fields.index(parameters.x_axis.value),
            key=parameters.x_axis.key,
            on_change=functools.partial(
                parameters.update_parameter_from_session_state,
                key=parameters.x_axis.key,
            ),
        )


def show_y_axis(parameters):
    return st.selectbox(
        label="y-as",
        options=data_fields,
        index=data_fields.index(parameters.y_axis.value),
        key=parameters.y_axis.key,
        on_change=functools.partial(
            parameters.update_parameter_from_session_state,
            key=parameters.y_axis.key,
        ),
    )


def show_z_axis(parameters):
    return st.selectbox(
        label="z-as",
        options=data_fields,
        index=data_fields.index(parameters.z_axis.value),
        key=parameters.z_axis.key,
        on_change=functools.partial(
            parameters.update_parameter_from_session_state,
            key=parameters.z_axis.key,
        ),
    )



def show_color(parameters):
    return st.selectbox(
        label="Kleur",
        options=data_fields,
        index=data_fields.index(parameters.color.value),
        key=parameters.color.key,
        on_change=functools.partial(
            parameters.update_parameter_from_session_state,
            key=parameters.color.key,
        ),
    )


def mjs_plot(chart_type: str, df):
    """return plotly plots"""

    parameters = streamlit_parameters.parameters.Parameters()
    parameters.register_string_parameter(key="x_axis", default_value="timestamp")
    parameters.register_string_parameter(key="y_axis", default_value="temperature_mean")
    parameters.register_string_parameter(key="z_axis", default_value="humidity_mean")
    parameters.register_string_parameter(key="color", default_value="id")
    parameters.register_string_parameter(key="plot_title", default_value="Gemiddelde temperatuur van meetkastje 725 in 2021")
# 782 68 2008 2028
    plot_title = st.text_input(
        label="Titel van jouw grafiek",
        value=parameters.plot_title.value,
        key=parameters.plot_title.key,
        on_change=functools.partial(
            parameters.update_parameter_from_session_state,
            key=parameters.plot_title.key,
        )
    )

    if chart_type == "Scatter":
        x_axis = show_x_axis(parameters)
        y_axis = show_y_axis(parameters)
        color = show_color(parameters)

        fig = px.scatter(
            data_frame=df,
            x=x_axis,
            y=y_axis,
            color=color,
            title=plot_title,
        )
    elif chart_type == "Histogram":
        x_axis = show_x_axis(parameters)

        fig = px.histogram(
            data_frame=df,
            x=x_axis,
            title=plot_title,
        )
    elif chart_type == "Bar":
        x_axis = show_x_axis(parameters)
        y_axis = show_y_axis(parameters)

        fig = px.histogram(data_frame=df, x=x_axis, y=y_axis, title=plot_title)
        # by default shows stacked bar chart (sum) with individual hover values
    elif chart_type == "Boxplot":
        x_axis = show_x_axis(parameters)
        y_axis = show_y_axis(parameters)

        fig = px.box(data_frame=df, x=x_axis, y=y_axis, title=plot_title)
    elif chart_type == "Line":
        x_axis = show_x_axis(parameters)
        y_axis = show_y_axis(parameters)
        color = show_color(parameters)
        fig = px.line(
            data_frame=df,
            x=x_axis,
            y=y_axis,
            color=color,
            title=plot_title,
        )
    elif chart_type == "3D Scatter":
        x_axis = show_x_axis(parameters)
        y_axis = show_y_axis(parameters)
        z_axis = show_z_axis(parameters)
        color = show_color(parameters)

        fig = px.scatter_3d(
            data_frame=df,
            x=x_axis,
            y=y_axis,
            z=z_axis,
            color=color,
            title=plot_title,
        )

    return fig
