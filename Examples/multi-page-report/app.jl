import HTTP, CSV, JSON
using Dashboards, PlotlyBase, DataFrames, Dates
external_stylesheets = [
    "https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css",
    "https://codepen.io/chriddyp/pen/bWLwgP.css",
    "assets/styles.css",
]

ClassData = CSV.read("/data/Class_Data.csv")

app = Dash(
    "Report",
    external_stylesheets = external_stylesheets,
    assets_folder = "assets",
) do
    html_div(className = "grey lighten-4") do
        html_br(),
        html_div(className = "container white") do
            html_div(className = "row container-min") do
                html_div(className = "col s12 center-align blue white-text") do
                    html_br(),
                    html_h2("Dashboards.jl"),
                    html_p("Report"),
                    html_br()
                end,
                html_br(),
                html_br(),
                html_div(className = "col s12 m4 center-align") do
                    html_br(),
                    html_div(className = "card-panel teal white-text") do
                        html_h5("Mudit Somani"),
                        html_p(raw"+91 98690137689"),
                        html_p(raw"mudit.somani@gmail.com")
                    end,
                    html_br(),
                    html_div(className = "card-panel teal white-text") do
                        html_h5("Harshit Somani"),
                        html_p(raw"+91 98690137689"),
                        html_p(raw"harshit.somani@gmail.com")
                    end,
                    html_br(),
                    html_div(className = "card-panel teal white-text") do
                        html_h5("Another Name"),
                        html_p(raw"+91 98690135467"),
                        html_p(raw"johndoe@gmail.com")
                    end
                end,
                html_div(className="col s12 m8") do
                    html_h3("Title 1"),
                    html_p(raw"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                    html_h3("Title 2"),
                    html_p(raw"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                    html_a("Learn More", className="btn red", href="#")
                end
            end
        end,
        html_br(),
        html_br(),
        html_div(className = "container white") do
            html_div(className = "row container-min") do
                html_div(className="col s12") do
                    html_br(),
                    html_br(),
                    html_h3("Title 1", className="center-align"),
                    html_p(raw"Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut.Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut."),
                    html_h3("Title 2", className="center-align"),
                    html_p(raw"Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut.Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut."),
                    html_blockquote("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                    html_h3("Title 3", className="center-align"),
                    html_p(raw"Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut.Adipisci dolore magnam porro quaerat dolorem quaerat aliquam. Voluptatem non magnam est amet non. Ut etincidunt labore est non. Non ut consectetur labore consectetur neque. Non modi aliquam labore voluptatem. Etincidunt dolorem aliquam velit velit voluptatem. Etincidunt voluptatem adipisci velit neque quisquam. Porro est tempora ipsum est labore. Quisquam amet non sed dolor quiquia quisquam modi. Aliquam ipsum quisquam sed ut."),
                    html_br(),
                    html_br()
                end
            end
        end,
        html_br(),
        html_br(),
        html_div(className = "container white") do
            html_div(className = "row container-min") do
                html_div(className="col s12 m6") do
                    html_br(),
                    html_h4("Graph 1", className="blue-text center-align"),
                    dcc_graph(
                        figure=(
                            data = [
                                (
                                    x = ["Year 1", "Year 2", "Year 3", "Year 4"],
                                    y = [10, 20, 25, 23],
                                    type = "bar"
                                )
                            ],
                            layout = (
                                hovermode = "closest",
                                autosize = false,
                                title = "",
                                width = 400,
                                height = 500,
                            )
                        )
                    )
                end,
                html_div(className="col s12 m6") do
                    html_br(),
                    html_h4("Graph 2", className="green-text center-align"),
                    dcc_graph(
                        figure=(
                            data = [
                                (
                                    x = [5, 6, 8, 11],
                                    y = [10, 20, 25, 23],
                                    type = "scatter"
                                )
                            ],
                            layout = (
                                hovermode = "closest",
                                autosize = false,
                                title = "",
                                width = 400,
                                height = 500,
                            )
                        )
                    )
                end,
                html_div() do
                    dcc_graph(figure = Plot(df,
                                Layout(
                                    xaxis_type = "log",
                                    xaxis_title = "Study",
                                    yaxis_title = "Marks",
                                    legend_x = 0,
                                    legend_y = 1,
                                    hovermode = "closest"
                                ),
                                    x=Symbol("Study"),
                                    y=Symbol("Marks"),
                                    text = :Name,
                                    mode="markers",
                                    group=:Gender,
                                    marker_size = 10,
                                    marker_line_width = 1,
                                    marker_line_color = "blue"
                            ))
                end
            end
        end
    end
end

handler = make_handler(app, debug = true)
println("Started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
