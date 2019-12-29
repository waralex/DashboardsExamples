#Importing packages required
import HTTP
using Dashboards, PlotlyJS, DataFrames, HTTP, CSV, JSON, DataFramesMeta

#getting the data
df = CSV.read(HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/2014_ebola.csv").body)
df = dropmissing(df)

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css","https://codepen.io/ihackyouridevice/pen/eYmEjOP.css"]


#Constructing Dashboard Application
app = Dash("Ebola Cases in Africa : PiePlot", external_stylesheets=external_stylesheets) do 
    html_div() do 
        #heading 
        html_h1("Ebola Cases Reported in Africa - 2014",
        style=(
                textAlign = "center",
                color = "#2d3436",
                paddingBottom = "0%",
            )
        )
        #actual graph
        html_div(className = "container", style = (textAlign = "center", margin ="30px", padding = "10px", width="65%", marginLeft="auto", marginRight="auto")) do 
            dcc_graph(id = "my-graph"),
            dcc_slider(
                id = "month-selected",
                min = 3,
                max = 12,
                marks = Dict(3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December"),

                value = 8,
            )
        end
    end
end

callback!(app, callid"month-selected.value => my-graph.figure") do selected
    Plot(
        df[df.Month .== selected, :],
        Layout(
            title = "Cases Reported Monthly",
            margin = Dict("l" => 300, "r" => 300),
            legend = Dict("x" => 1, "y" => 0.7)
        ),
        marker = Dict("colors" => ["#EF963B", "#C93277", "#349600", "#EF533B", "#57D4F1"]),
        textinfo = "label"
    )
end


handler = make_handler(app, debug = true)
println("App started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)


