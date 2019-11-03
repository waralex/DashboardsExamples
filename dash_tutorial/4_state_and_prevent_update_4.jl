# Dashboards implementation of example from Dash Tutorial (section More About Callbacks) (https://dash.plot.ly/state)

import HTTP
using Dashboards

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]

function prime_factors(num::Int64)
    n = num
    i = 2
    out = Int64[]
    while i * i <= n
        if n % i == 0
            n = div(n, i)
            push!(out, i)            
        else
            i += (i == 2) ? 1 : 2
        end                
    end
    push!(out, n)
    return out
end

app = Dash("Dash Layout", external_stylesheets=external_stylesheets) do
    html_div() do
        html_p("Enter a composite number to see its prime factors"),
        dcc_input(id="num", type="number", debounce=true, min=1, step=1),
        html_p(id = "err", style = (color = "red",)),
        html_p(id = "out")        
    end
end

callback!(app, callid"""num.value => out.children, err.children""") do num

    if isnothing(num)
        throw(PreventUpdate())
    end

    factors = prime_factors(num)
    if length(factors) == 1
        return no_update(), "$(num) is prime!"
    end
    
    return "$(num) is $(join(string.(factors), " * "))", " "
    
end

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)

#=
app.layout = html.Div([
    html.P('Enter a composite number to see its prime factors'),
    dcc.Input(id='num', type='number', debounce=True, min=1, step=1),
    html.P(id='err', style={'color': 'red'}),
    html.P(id='out')
])

@app.callback(
    [Output('out', 'children'), Output('err', 'children')],
    [Input('num', 'value')]
)
def show_factors(num):
    if num is None:
        # PreventUpdate prevents ALL outputs updating
        raise dash.exceptions.PreventUpdate

    factors = prime_factors(num)
    if len(factors) == 1:
        # dash.no_update prevents any single output updating
        # (note: it's OK to use for a single-output callback too)
        return dash.no_update, '{} is prime!'.format(num)

    return '{} is {}'.format(num, ' * '.join(str(n) for n in factors)), ''

def prime_factors(num):
    n, i, out = num, 2, []
    while i * i <= n:
        if n % i == 0:
            n = int(n / i)
            out.append(i)
        else:
            i += 1 if i == 2 else 2
    out.append(n)
    return out
    =#