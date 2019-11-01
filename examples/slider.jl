#=
Simple example with slider and graph
=#
import HTTP
using Dashboards
function make_graph_figure(coeff)
   x_range = -10.0:0.1:10   
   (
       data = [(
           x = x_range,
           y = [coeff * x^2 + 3.0 * x + 7.0 for x in x_range]
       )],
       layout = (title = "$(coeff) * x^2 + 3.0 * x + 7.0",)
   ) 
end
app = Dash("Simple Slider", external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]) do
    html_div() do
        html_h1("Slider example"),
        
        dcc_slider(
            id="slider", min=0., max=4., step=0.05, value = 0.,
            updatemode = :drag, tooltip = (always_visible=true,),
            marks = Dict(map(x -> x=>x, 0:0.5:4.1))
        ),                
        dcc_graph(
            id="graph",
            figure = make_graph_figure(0.),
            style = Dict("padding-top" => "20px")
            )
        
                    
    end
end
callback!(app, callid"slider.value => graph.figure") do value
    return make_graph_figure(value)
end
handler = make_handler(app)
HTTP.serve(handler, HTTP.Sockets.localhost, 8050)