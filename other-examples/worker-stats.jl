import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames
external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
df = CSV.read(HTTP.get("https://people.sc.fsu.edu/~jburkardt/data/csv/biostats.csv").body)
app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_graph(figure = Plot(df,
                    Layout(xaxis_type = "log",
                        xaxis_title = "Weight (lbs)",
                        yaxis_title = "Height (in)",
                        legend_x = 0,
                        legend_y = 1,
                        hovermode = "closest"),
                    x=Symbol("Weight (lbs)"),
                    y=Symbol("Height (in)"),
                    text = :Name,
                    mode="markers",
                    group=:Sex,
                    marker_size = 10,
                    marker_line_width = 0.4,
                    marker_line_color = "white"
                    ))
    end
end

handler = make_handler(app, debug = true)
println("Started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
