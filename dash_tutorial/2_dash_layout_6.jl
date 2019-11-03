# Dashboards implementation of example from Dash Tutorial (section Dash Layout) (https://dash.plot.ly/getting-started)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div(style=(columnCount = 2,)) do
        html_label("Dropdown"),
        dcc_dropdown(
            options = [
                (label = "New York City", value = "NYC"),
                (label = "Montréal", value = "MTL"),
                (label = "San Francisco", value = "SF")
            ],
            value = "MTL"
        ),
        html_label("Multi-Select Dropdown"),
        dcc_dropdown(
            options = [
                (label = "New York City", value = "NYC"),
                (label = "Montréal", value = "MTL"),
                (label = "San Francisco", value = "SF")
            ],
            value = ["MTL", "SF"],
            multi = true
        ),
        html_label("Radio Items"),
        dcc_radioitems(
            options = [
                (label = "New York City", value = "NYC"),
                (label = "Montréal", value = "MTL"),
                (label = "San Francisco", value = "SF")
            ],
            value = "MTL",
            
        ),
        html_label("Checkboxes"),
        dcc_checklist(
            options = [
                (label = "New York City", value = "NYC"),
                (label = "Montréal", value = "MTL"),
                (label = "San Francisco", value = "SF")
            ],
            value = ["MTL", "SF"] 
        ),
        html_label("Text Input"),
        dcc_input(value="MTL", type=:text),
        html_label("Slider"),
        dcc_slider(
            min =0,
            max = 9,
            marks = Dict([i=>(i==1 ? "Label $(i)" : "$(i)") for i in 1:6]),
            value = 5 
        )        
    end
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)