# Dashboards implementation of example from Dash Tutorial (section Dash Layout) (https://dash.plot.ly/getting-started)
import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
colors = (
    background = "#111111",
    text = "#7FDBFF"
)

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div(style = (backgroundColor = colors.background,)) do
        html_h1("Hello Dash",
            style=(
                textAlign = "center",
                color = colors.text
            )
        ),
        html_div("Dash: A web application framework for Python.",
            style=(
                textAlign = "center",
                color = colors.text
            )
        ),
        dcc_graph(
            id = "example-graph",
            figure=(
                data = [
                    (x = [1, 2, 3], y = [4, 1, 2], type = "bar", name = "SF"),
                    (x = [1, 2, 3], y = [2, 4, 5], type = "bar", name = "Montréal"),
                ],
                layout =  (
                    plot_bgcolor =  colors.background,
                    paper_bgcolor = colors.background,
                    font = (
                        color = colors.text
                    )
                )
            )
        )
    end
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)