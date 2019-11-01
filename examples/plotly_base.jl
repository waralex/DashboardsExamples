#=
An example of using PlotlyBase interface for testing issue https://github.com/waralex/Dashboards/issues/1
Basing on slider example
=#
import HTTP, JSON, JSON2

using Dashboards, PlotlyBase
#We can't marshal PlotlyBase.Plot directly with JSON2 because its structure does not match required json.
#There is overload for JSON.lower to fix it in PlotlyBase 
#So mixing of JSON and JSON2 is not very elegant, but it works out of box
JSON2.write(io::IO, p::Plot; kwargs...) = write(io, JSON.json(p))


function make_graph_figure(coeff)
   
end
app = Dash("Simple Slider", external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]) do
    html_div() do
        html_h1("PlotlyBase usage"),
        
        dcc_slider(
            id="slider", min=0., max=4., step=0.05, value = 0.,
            updatemode = :drag, tooltip = (always_visible=true,),
            marks = Dict(map(x -> x=>x, 0:0.5:4.1))
        ),     
        #I don't set figure property because of first callback executed after initial load and that callback will return figure property        
        dcc_graph(
            id="graph",            
            style = Dict("padding-top" => "20px")
            )
        
                    
    end
end
callback!(app, callid"slider.value => graph.figure") do value
    #the callback return Plot struct and due to overloads JSON2.write and JSON.lower for this structure sends the corresponding json struct to frontend
    return Plot(x->value * x^2 + 3.0 * x + 7.0, -10, 10, Layout(title = "$(value) * x^2 + 3.0 * x + 7.0"))    
end
handler = make_handler(app)
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)