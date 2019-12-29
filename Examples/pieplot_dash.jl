#Importing packages required
import HTTP
using Dashboards, PlotlyJS, DataFrames, HTTP, CSV, JSON, DataFramesMeta

#getting the data
df = CSV.read(HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/2014_ebola.csv").body)
df = dropmissing(df)

external_stylesheets = ["https://codepen.io/ihackyouridevice/pen/povrOWv.css","https://codepen.io/ihackyouridevice/pen/Jjoyary.css"]

palette = (text = "#222f3e", bg = "#ffffff")

#Constructing Dashboard Application
app = Dash("Dashboard.jl", external_stylesheets=external_stylesheets) do
    html_div(style = (backgroundColor = palette.bg, height = "100%")) do
        #Sets and styles heading/title
        html_h1("Ebola Cases Reported in Africa - 2014",
            style=(
               textAlign = "center",
               paddingBotton = "0%",
               color = palette.text,
               fontFamily = "Helvetica",
               fontSize = "82",
            )
        ),
        html_div(className = "container", style = (textAlign="center", margin="30px", padding="10px", width="65%", marginLeft="auto", marginRight="auto")) do
            dcc_graph(
               id = "my-graph"
            ),
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
        #how to complete this.
    )

end


handler = make_handler(app, debug = true)
println("Come On Madhav ! You can do this!!!")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)


