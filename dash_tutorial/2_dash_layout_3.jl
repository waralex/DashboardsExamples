# Dashboards implementation of example from Dash Tutorial (section Dash Layout) (https://dash.plot.ly/getting-started)
import HTTP, CSV
using Dashboards, DataFrames
external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
println("downloading data for the graph....")
df = CSV.read(
        HTTP.get("https://gist.githubusercontent.com/chriddyp/c78bf172206ce24f77d6363a2d754b59/raw/c353e8ef842413cae56ae3920b8fd78468aa4cb2/usa-agricultural-exports-2011.csv").body
    )


function generate_table(df::DataFrame; max_rows = 10)
    html_table() do 
         vcat(
            #head
            [html_tr(html_th.(names(df)))],
            #body
            [
                html_tr() do
                    [html_td(x) for x in df[row,:]]
                end
                for row in 1:min(size(df,1), max_rows)
            ]
        )
    end
end

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        html_h4("US Agriculture Exports (2011)"),
        generate_table(df)
    end
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)


