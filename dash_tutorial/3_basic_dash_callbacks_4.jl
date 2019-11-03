# Dashboards implementation of example from Dash Tutorial (section Basic Dash Callbacks) (https://dash.plot.ly/getting-started-part-2)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_input(id = "num", value = 5, type="number"),
        html_table() do
            html_tr() do
                html_td(("x", html_sup(2))),
                html_td(id="square")
            end,
            html_tr() do
                html_td(("x", html_sup(3))),
                html_td(id="cube")
            end,
            html_tr() do
                html_td((2, html_sup("x"))),
                html_td(id="twos")
            end,
            html_tr() do
                html_td((3, html_sup("x"))),
                html_td(id="threes")
            end,
            html_tr() do
                html_td(("x", html_sup("x"))),
                html_td(id="x-x")
            end
        end
    end
end
callback!(app, callid"""num.value => 
            square.children, cube.children, twos.children, threes.children, x-x.children """  ) do x
    x^2, x^3, 2^x, 3^x, x^x
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)