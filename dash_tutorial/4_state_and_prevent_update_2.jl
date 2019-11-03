# Dashboards implementation of example from Dash Tutorial (section More About Callbacks) (https://dash.plot.ly/state)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_input(id = "input-1-state", type = "text", value = "Montréal"),
        dcc_input(id = "input-2-state", type = "text", value = "Canada"),
        html_button("Submit", id = "submit-button", n_clicks = 0),
        html_div(id = "output-state")
    end
end

callback!(app, callid"""{input-1-state.value, input-2-state.value}
                         submit-button.n_clicks 
                         => output-state.children""") do input1, input2, n_clicks

    """The Button has been pressed $(n_clicks) times,
        Input 1 is "$(input1)"
        and Input 2 is "$(input2)"
    """
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)