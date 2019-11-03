# Dashboards implementation of example from Dash Tutorial (section Dash Layout) (https://dash.plot.ly/getting-started)

import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
println("downloading data for the graph....")
df = CSV.read(
        HTTP.get("https://gist.githubusercontent.com/chriddyp/" *
        "5d1ea79569ed194d432e56108a04d188/raw/" *
        "a9f9e8076b837d541398e999dcbac2b2826a81f8/" *
        "gdp-life-exp-2007.csv").body
    )

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        #You can use PlotlyBase.Plot to make figure property of dcc_graph
        dcc_graph(
           figure = Plot(df,
                    Layout(
                        xaxis_type = "log",
                        xaxis_title = "GDP Per Capita",
                        yaxis_title = "Life Expectancy",
                        legend_x = 0,
                        legend_y = 1,
                        hovermode = "closest"
                    ),
                    x=Symbol("gdp per capita"),
                    y=Symbol("life expectancy"), 
                    text = :country,
                    mode="markers",
                    group=:continent,
                    marker_size = 15,
                    marker_line_width = 0.5,
                    marker_line_color = "white"                    
                    )
       )
    end
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)


