
import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames
external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
df = CSV.read(HTTP.get("https://people.sc.fsu.edu/~jburkardt/data/csv/mlb_teams_2012.csv").body)
app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_graph(figure = Plot(df,
                    Layout(xaxis_type = "log",
                        xaxis_title = "Payroll (millions)",
                        yaxis_title = "Wins",
                        legend_x = 0,
                        legend_y = 1,
                        hovermode = "closest"),
                    x=Symbol("Payroll (millions"),
                    y=Symbol("Wins"),
                    text = :Team,
                    mode="markers",
                    group=:Wins,
                    marker_size = 30,
                    marker_line_width = 1,
                    marker_line_color = "blue"
                    ))
    end
end

handler = make_handler(app, debug = true)
println("Started at localhost:8000")
HTTP.serve(handler, HTTP.Sockets.localhost, 8000)
