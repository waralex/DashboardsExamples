import HTTP
using Dashboards
app = Dash("Test app", external_stylesheets = ["https://codepen.io/Kola58/pen/VwYrwrL.css"]) do
    html_div() do
        html_h1("GDP for the top 20 countries in 2019"),
        html_div("The highest GDP in 2019: China"),
        dcc_graph(
            id = "gdp-graph",
            figure = (
                data = [
                    (x = [2019], y = [27308857], type = "bar", name = "China"),
                    (x = [2019], y = [21439453], type = "bar", name = "US"),
                    (x = [2019], y = [11325669], type = "bar", name = "India"),
                    (x = [2019], y = [5747496], type = "bar", name = "Japan"),
                    (x = [2019], y = [4444368], type = "bar", name = "Germany"),
                    (x = [2019], y = [4349423], type = "bar", name = "Russia"),
                    (x = [2019], y = [3737484], type = "bar", name = "Indonesia"),
                    (x = [2019], y = [3456357], type = "bar", name = "Brazil"),
                    (x = [2019], y = [3131199], type = "bar", name = "United Kingdom"),
                    (x = [2019], y = [3061143], type = "bar", name = "France"),
                    (x = [2019], y = [2627851], type = "bar", name = "Mexico"),
                    (x = [2019], y = [2442768], type = "bar", name = "Italy"),
                    (x = [2019], y = [2346576], type = "bar", name = "Turkey"),
                    (x = [2019], y = [2319585], type = "bar", name = "South Korea"),
                    (x = [2019], y = [1940539], type = "bar", name = "Spain"),
                    (x = [2019], y = [1899935], type = "bar", name = "Canada"),
                    (x = [2019], y = [1898511], type = "bar", name = "Saudi Arabia"),
                    (x = [2019], y = [1470661	], type = "bar", name = "Iran"),
                    (x = [2019], y = [1391256	], type = "bar", name = "Egypt"),
                    (x = [2019], y = [1383022	], type = "bar", name = "Thailand"),
                ],
                layout = (title = "List by the International Monetary Fund",)
            )
        )
    end
end
handler = make_handler(app, debug = true)
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)