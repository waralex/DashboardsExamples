# Dashboards implementation of example from Dash Tutorial (section Interactive Visualizations) (https://dash.plot.ly/interactive-graphing)

import HTTP, CSV, JSON
using Dashboards, PlotlyJS, DataFrames

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
println("downloading data for the graph....")
df = CSV.read(
        HTTP.get("https://gist.githubusercontent.com/chriddyp/" *
        "cb5392c35661370d95f300086accea51/raw/" *
        "8e0768211f6b747c0db42a9ce9a0937dafcbd8b2/" *
        "indicators.csv").body
    )
df = dropmissing(df)
available_indicators = unique(df[:,Symbol("Indicator Name")])

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        html_div() do
            html_div(style = (width="48%", display="inline-block")) do
                dcc_dropdown(
                    id = "xaxis-column",
                    options = [(label = i, value = i) for i in available_indicators],
                    value="Fertility rate, total (births per woman)"
                ),
                dcc_radioitems(
                    id="xaxis-type",
                    options=[(label = i, value = i)  for i in ["Linear", "Log"]],
                    value="Linear",
                    labelStyle=(display = "inline-block",)
                )
            end,
            html_div(style = (width="48%", display="inline-block", float="right")) do
                dcc_dropdown(
                    id = "yaxis-column",
                    options = [(label = i, value = i) for i in available_indicators],
                    value="Life expectancy at birth, total (years)"
                ),
                dcc_radioitems(
                    id="yaxis-type",
                    options=[(label = i, value = i)  for i in ["Linear", "Log"]],
                    value="Linear",
                    labelStyle=(display = "inline-block",)
                )
            end

        end,    
        html_div(style=(width = "49%", display = "inline-block", padding = "0 20")) do
            dcc_graph(id = "crossfilter-indicator-scatter")
        end,
        html_div(style=(width = "49%", display = "inline-block")) do
            dcc_graph(id = "x-time-series"),
            dcc_graph(id = "y-time-series")
        end,
        html_div(style=(width = "49%", padding = "0px 20px 20px 20px")) do
            dcc_slider(
                id = "year-slider",
                min = minimum(df[:,:Year]),
                max = maximum(df[:,:Year]),
                value = minimum(df[:,:Year]),
                marks = Dict([Symbol(v)=>Symbol(v) for v in unique(df[:,:Year])]),
                step = nothing
                )
        end
    end
end

callback!(app, 
    callid"""xaxis-column.value, yaxis-column.value, xaxis-type.value, yaxis-type.value, year-slider.value
    => crossfilter-indicator-scatter.figure""") do xaxis_column_name, yaxis_column_name, xaxis_type, yaxis_type, year_value
    dff = df[df.Year .== year_value, :] 
    Plot(
        dff[dff[Symbol("Indicator Name")] .== xaxis_column_name, :Value],
        dff[dff[Symbol("Indicator Name")] .== yaxis_column_name, :Value],
        Layout(
            xaxis_type = xaxis_type == "Linear" ? "linear" : "log",
            xaxis_title = xaxis_column_name,
            yaxis_title = yaxis_column_name,
            yaxis_type = yaxis_type == "Linear" ? "linear" : "log",
            hovermode = "closest",
            height=450
        ),
        kind = "scatter",
        text = dff[dff[Symbol("Indicator Name")] .== yaxis_column_name, Symbol("Country Name")],
        customdata = dff[dff[Symbol("Indicator Name")] .== yaxis_column_name, Symbol("Country Name")],
        mode = "markers",
        marker_size = 15,
        marker_opacity = 0.5,
        marker_line_width = 0.5,
        marker_line_color = "white" 

    )
    
end

function create_time_series(dff, axis_type, title)
    Plot(
        dff[:, :Year],
        dff[:, :Value],
        Layout(                        
            yaxis_type = axis_type == "Linear" ? "linear" : "log",            
            xaxis_showgrid = false,
            annotations = [
                attr(
                    x = 0,
                    y = 0.85,
                    xanchor = "left",
                    yanchor = "bottom",
                    xref = "paper",
                    yref = "paper",
                    showarrow = false,
                    align = "left",
                    bgcolor = "rgba(255, 255, 255, 0.5)",
                    text = title
                )
            ],         
            height=225
        ),
        mode = "lines+markers"
    )
end

callback!(app, callid"""
                crossfilter-indicator-scatter.hoverData,
                xaxis-column.value,
                xaxis-type.value => x-time-series.figure
                """) do hover_data, xaxis_column_name, axis_type
    
    country_name = isnothing(hover_data) ? "" : hover_data.points[1].customdata
    dff = df[df[:,Symbol("Country Name")] .==  country_name, :]
    dff = dff[dff[:,Symbol("Indicator Name")] .==  xaxis_column_name, :]
    title = "<b>$(country_name)</b><br>$(xaxis_column_name)"
    create_time_series(dff, axis_type, title)
end

callback!(app, callid"""
                crossfilter-indicator-scatter.hoverData,
                yaxis-column.value,
                yaxis-type.value => y-time-series.figure
                """) do hover_data, yaxis_column_name, axis_type
    
    country_name = isnothing(hover_data) ? "" : hover_data.points[1].customdata
    dff = df[df[:,Symbol("Country Name")] .==  country_name, :]
    dff = dff[dff[:,Symbol("Indicator Name")] .==  yaxis_column_name, :]
    
    create_time_series(dff, axis_type, yaxis_column_name)
end



handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)