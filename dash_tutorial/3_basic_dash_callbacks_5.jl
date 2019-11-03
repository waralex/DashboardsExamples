# Dashboards implementation of example from Dash Tutorial (section Basic Dash Callbacks) (https://dash.plot.ly/getting-started-part-2)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

all_options = (
    America = ["New York City", "San Francisco", "Cincinnati"],
    Canada = ["Montréal", "Toronto", "Ottawa"]
)

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        dcc_radioitems(
            id = "countries-dropdown",
            options = [(label = i, value = i) for i in keys(all_options)],
            value = :America
        ),
        html_hr(),
        dcc_radioitems(id = "cities-dropdown"),
        html_hr(),
        html_div(id = "display-selected-values")
        
    end
end

callback!(app, callid"countries-dropdown.value => cities-dropdown.options") do selected_country
    
    return map(all_options[Symbol(selected_country)]) do i
        (label = i, value = i)
    end
end

callback!(app, callid"cities-dropdown.options => cities-dropdown.value") do available_options    
    available_options[1].value    
end

callback!(app, callid"countries-dropdown.value, cities-dropdown.value => display-selected-values.children") do selected_country, selected_city
    "$(selected_city) is a city in $(selected_country)"
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
