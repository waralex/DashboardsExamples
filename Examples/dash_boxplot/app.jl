
# Inspired by https://github.com/plotly/simple-example-chart-apps/tree/master/dash-boxplot

import HTTP, JSON, CSV
using Dashboards, PlotlyBase, DataFrames
external_stylesheets = ["$(Base.source_dir())/assets/styles.css"]
ClassData = CSV.read("$(Base.source_dir())/data/data.csv")
app = Dash("Box Plot", external_stylesheets=external_stylesheets) do
    html_div(style = (text_align: "center")) do
        html_h1("Greenhouse Gas Emissions by Continent"),
        #to add graph here



    end
end 


handler = make_handler(app, debug = true)
println("Started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
