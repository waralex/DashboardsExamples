# Dashboards implementation of example from Dash Tutorial (section Dash Layout) (https://dash.plot.ly/getting-started)
# Inspired by https://github.com/waralex/DashboardsExamples/blob/master/dash_tutorial/2_dash_layout_4.jl
import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames
dashapp = Dash("Dash Layout", external_stylesheets=external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]) do
    html_div() do
        dcc_graph(figure = Plot(CSV.read(HTTP.get("https://people.sc.fsu.edu/~jburkardt/data/csv/biostats.csv").body),
                    Layout(xaxis_type = "log", xaxis_title = "Weight (lbs)", yaxis_title = "Height (in)", legend_x = 0, legend_y = 1, hovermode = "closest"),
                    x=Symbol("Weight (lbs)"),
                    y=Symbol("Height (in)"),
                    text = :Name,
                    mode="markers",
                    group=:Sex,
                    marker_size = 10,
                    marker_line_width = 0.4,
                    marker_line_color = "white"))
    end
end
HTTP.serve(make_handler(dashapp, debug = true), HTTP.Sockets.localhost, 8080)
println("Started at localhost:8080")
