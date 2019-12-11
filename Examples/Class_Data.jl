
import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames
external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
df = CSV.read(HTTP.get("https://filebin.net/og3ajfopziv4453x/Class_Data.csv?t=7et6ovzg").body)
app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_graph(figure = Plot(df,
                    Layout(xaxis_type = "log",
                        xaxis_title = "Study",
                        yaxis_title = "Marks",
                        legend_x = 0,
                        legend_y = 1,
                        hovermode = "closest"),
                    x=Symbol("Study"),
                    y=Symbol("Marks"),
                    text = :Name,
                    mode="markers",
                    group=:Gender,
                    marker_size = 10,
                    marker_line_width = 1,
                    marker_line_color = "blue"
                    ))
    end
end

handler = make_handler(app, debug = true)
println("Started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
