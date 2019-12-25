#This is an example dashboard implemented from the Dash python website. 
# url: https://dash.plot.ly/dash-core-components
# source of data: https://qz.com/122003/plastic-recycling-china-green-fence/

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

app = Dash("Plastic Exports", external_stylesheets=external_stylesheets) do
    html_div() do
        html_h2("Dashboards.jl interactive graph",
            style=(
                textAlign = "center",
                color = "#8c8c8c"
            )
        ),


        dcc_graph(
            id = "my-graph",

            figure = (
                data = [
                (x=[1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                y=[219, 146, 112, 127, 124, 180, 236, 207, 236, 263, 350, 430, 474, 526, 488, 537, 500, 439],
                name = "Rest of world"),

                (x = [1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                y = [16, 13, 10, 11, 28, 37, 43, 55, 56, 88, 105, 156, 270, 299, 340, 403, 549, 499],
                name = "China"),

                ],

                layout = (
                    title = "US export of plastic scrap",
                    showlegend = true,
                    legend = (x = 0, y = 1.0),
                    margin = (l = 40, r = 0, t = 40, b = 30)
                ),

                #style = ("height": 300)

            )
        )
    end
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
