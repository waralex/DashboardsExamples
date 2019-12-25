using Dashboards # Duh'
using HTTP # To display it on the net
using Calculus # To calculate the slope of the tangent

# The following code is more focused on backend side of things.
# That being said, Dashboards.jl offers extensive front-end customizability,
# which everyone should check out whilst building their project.



app = Dash(
    "tangent n stuff",
    external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"],
) do
    html_div(style = (backgroundColor = "#111111", color = "#7FDBFF")) do
        html_div(style = (textAlign = "center",)) do
            html_h1("Graphing Tool")
        end,

        html_table(style = (width = "100%", hight = "100%")) do
            html_tr() do
                html_td(style = (width = "25%", textAlign = "center")) do
                    html_div(id = "equations") do
                        dcc_checklist(
                        id = "show",
                        options=[
                            (label="SHOW TANGENT", value="SHOW")
                        ],
                        value=["SHOW"]
                        ),
                        html_button(
                            "submit",
                            id = "submit",
                            style = (margin = "15px 15px",),
                        ),
                        dcc_input(
                            id = "equation",
                            value = "x^2",
                            style = (margin = "15px 15px",),
                        ),
                        html_div(style = (margin = "15px 15px",)) do # slider to measure how much to move along the x axis.
                            dcc_slider(
                                id = "xmove",
                                value = 0,
                                min = -2000,
                                max = 2000,
                                step = 10,
                            )
                        end,
                        html_h3("move along x"),
                        html_div(style = (margin = "15px 15px",)) do # slider to measure how much to move along the x axis.
                            dcc_slider(
                                id = "ymove",
                                value = 0,
                                min = -3 * 10^6,
                                max = 3 * 10^6,
                                step = 1000,
                            )
                        end,
                        html_h3("move along y",)
                    end
                end,
                html_td(style = (width = "50%",)) do
                    html_div(style = (textAlign = "center",)) do
                        dcc_graph(id = "example-graph"),
                        html_div(style = (margin = "20px 15px",)) do # slider to measure the x coordinate at which we want to find the tangent(s).
                            dcc_slider(
                                id = "x_val",
                                value = 0,
                                min = -4000,
                                max = 4000,
                                step = 100,
                            )
                        end
                    end
                end
            end
        end
    end
end




callback!(
    app,
    callid"{equation.value} show.value, ymove.value, xmove.value, submit.n_clicks, x_val.value => example-graph.figure",
) do eq, show, ymove, xmove, _, xval # we want to update the graph everytime the user
                                     # toggles the SHOW TANGENT button
                                     # moves the sliders
                                     # presses the submit button
                                     # the equation.value is in {} to signify that its current state will be inputed. However,
                                     # it will not update the graph. This is because we dont want to update the graph while the user is typing.

    eqs = split(eq,",") # We expect the equations to be seperated by a ","
    data = []
    for i in 1:length(eqs)
        x, y, equation = getxyval(eqs[i], xmove = xmove, ymove = ymove) # this function returns the x, y arrays which consist of the points
                                                                        # which will be graphed. It also returns the mathematically correct equation
        if show == ["SHOW"]
            slope = string(differentiate(equation)) # diffrentiate the equation
            slope = split(slope, "") # the next few lines (till 24) find out the
            for j = 1:length(slope)  # slope of the tangent at the point "xval"
                slope[j] == "x" ? slope[j] = string("(", xval, ")") : nothing
            end
            slope = join(slope)
            slope = eval(Meta.parse(slope))
            yval = y[findfirst(u -> u == xval, x)]
            y1 = "$slope*(x-($xval)) + ($(yval))" # this is the equation of the tangent
                                                  # This was derived from the formula
                                                  # Y - y1 = m(X-x1) where x1,y1 are the known points that lie on the line
            x2, y2, lineeq = getxyval(y1)
            t2 = (                                # getting the data in correct format and adding it to the array "data"
                x=x2,
                y=y2,
                mode="line",
                name=lineeq
            )
            push!(data,t2)
            t3 = (                                # These will be the points where the tangent(s) intercept the curve
                                                  # So, we want to mark them with "markers".
             x = [xval],
             y = [yval],
             mode = "markers",
             marker_size = 15,
             opacity = 0.7,
             name = "($xval, $yval)",
            )
            push!(data,t3)
        end
        t = (x=x,y=y,mode="line",name=equation) # putting the x, y data (of the curve(s)) in correct format
        push!(data,t)
    end

    return (data = data,)
end



function getxyval(equation; xmove = 0, ymove = 0) # This equation returns the arrays which consist
                                                  # of the points which will be graphed for any given equation
    equation = split(equation, "")
    x = collect(-4000:10:4000) # all the x values for which we will graph the equation
    y = []
    for i = 1:length(equation) # The next couple of lines change the equation into a mathematically correct one.
        equation[i] == " " ? equation[i] = "" : nothing
        equation[i] == "x" ? equation[i] = string("(", "x", "- ($xmove)", ")") : # subtract the ammount desiered to move along the x axis
                                                                                 # to acctually move along the xaxis.
        nothing
        equation[i] == "+" || equation[i] == "*" || equation[i] == "/" ?
        equation[i] = string(" ", equation[i], " ") : nothing
    end

    push!(equation, " - ($ymove)") # We subtract the ammount we want to move along the y axis
                                   # to acctually move along the y axis.

    for j in x # now we find all the y values for all the x values
        temp = copy(equation) # we make a copy of equation because we dont want to
                              # edit the orignal equation which we need as it is.

        for i = 1:length(equation)
            if equation[i] == "(x- ($xmove))"
                temp[i] = string("(", j, "- ($xmove)", ")")
            end
        end
        temp = join(temp)
        anss = eval(Meta.parse(temp))
        push!(y, anss)

    end

    equation = join(equation)
    return (x, y, equation)

end


# boiler plate Dashboard code to run the application on local host

handler = make_handler(app, debug = true)
println("started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)

# The graph sometimes behaves a bit weird
# this is mainly due to Integer overflowing errors (we are working with HUGE numbers)
