# Dashboards implementation of example from Dash Tutorial (section Basic Dash Callbacks) (https://dash.plot.ly/getting-started-part-2)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_input(id = "my-id", value = "initial value", type="text"),
        html_div(id = "my-div")
    end
end
callback!(app, callid"my-id.value => my-div.children") do value
    "You\'ve entered $(value)"
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)