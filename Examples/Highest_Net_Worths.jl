# Example dashboard displaying rankings for the top net worths in the world

import HTTP
using Dashboards
app = Dash("app", external_stylesheets = ["https://codepen.io/Kola58/pen/VwYrwrL.css"]) do
    html_div() do
        html_h1("Global Net Worth Rankings"),
        dcc_graph(
            id = "net-worth",
            figure = (
                data = [
                    (x=[1], y=[110.1], type="bar", name="Jeff Bezos"),
                    (x=[2], y=[110.1], type="bar", name="Bill Gates"),
                    (x=[3], y=[101.2], type="bar", name="Bernard Arnault"),
                    (x=[4], y=[84.0], type="bar", name="Warren Buffett"),
                    (x=[5], y=[70.3], type="bar", name="Mark Zuckerberg"),
                    (x=[6], y=[70], type="bar", name="Amancio Ortega"),
                    (x=[7], y=[63.7], type="bar", name="Larry Ellison"),
                    (x=[8], y=[61.8], type="bar", name="Carlos Slim Helu"),
                    (x=[9], y=[57.9], type="bar", name="Larry Page"),
                    (x=[10], y=[57.4], type="bar", name="Sergey Brin"),
                    (x=[11], y=[57], type="bar", name="Mukesh Ambani"),
                    (x=[12], y=[56.9], type="bar", name="Steve Ballmer"),
                    (x=[13], y=[56.4], type="bar", name="Francoise Bettencourt Meyers"),
                    (x=[14], y=[56], type="bar", name="Michael Bloomberg"),
                    (x=[15], y=[53.2], type="bar", name="Jim Watson"),
                    (x=[16], y=[52.9], type="bar", name="Alice Walton"),
                    (x=[17], y=[52.8], type="bar", name="Robert Walton"),
                    (x=[18], y=[43.8], type="bar", name="Jack Ma"),
                    (x=[19], y=[43.1], type="bar", name="Ma Huateng"),
                    (x=[20], y=[43.0], type="bar", name="Charles Koch"),
                    (x=[21], y=[40.8], type="bar", name="Cheldon Adelson"),
                    (x=[22], y=[40.2], type="bar", name="Phil Knight"),
                    (x=[23], y=[39.4], type="bar", name="David Thompson"),
                    (x=[24], y=[37.4], type="bar", name="Mackenzie Bezos"),
                    (x=[25], y=[31.9], type="bar", name="Michael Dell"),
                ],
                layout = (title = "Highest 25 Net Worth Values (in billions) as of 2019",
                )
            )
        )
    end
end
handler = make_handler(app, debug = true)
println("localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
