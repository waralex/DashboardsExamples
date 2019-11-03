# Dashboards implementation of example from Dash Tutorial (section More About Callbacks) (https://dash.plot.ly/state)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do        
        html_button("Click here to see the content", id = "button"),
        html_div(id = "body-div")
    end
end

callback!(app, callid"""button.n_clicks => body-div.children""") do n_clicks

    if isnothing(n_clicks)
        throw(PreventUpdate())
    else
        return "Elephants are the only animal that can't jump"
    end
    
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)