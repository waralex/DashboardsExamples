# Dashboards implementation of example from Dash Tutorial (section Basic Dash Callbacks) (https://dash.plot.ly/getting-started-part-2)

import HTTP, CSV, JSON
using Dashboards, PlotlyJS, DataFrames

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
println("downloading data for the graph....")
df = CSV.read(
        HTTP.get("https://raw.githubusercontent.com/plotly/" *
        "datasets/master/gapminderDataFiveYear.csv").body
    )

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        
        dcc_graph(id = "graph-with-slider"),        
        dcc_slider(
            id = "year-slider",
            min = minimum(df[:,:year]),
            max = maximum(df[:,:year]),
            value = minimum(df[:,:year]),
            marks = Dict([Symbol(v)=>Symbol(v) for v in unique(df[:,:year])]),
            step = nothing
            )
    end
end

callback!(app, callid"year-slider.value => graph-with-slider.figure") do selected_year
    Plot(
        df[df.year .== selected_year, :],
        Layout(
            xaxis_type = "log",
            xaxis_title = "GDP Per Capita",
            yaxis_title = "Life Expectancy",
            legend_x = 0,
            legend_y = 1,
            hovermode = "closest"
        ),
        x=:gdpPercap,
        y=:lifeExp, 
        text = :country,
        mode="markers",
        group=:continent,
        marker_size = 15,
        marker_line_width = 0.5,
        marker_line_color = "white"         
    )
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)