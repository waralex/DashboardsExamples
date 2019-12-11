# Dashboards implementation of example from Dash Sample Apps

# Example: dash-financial-report (https://github.com/plotly/dash-sample-apps/tree/master/apps/dash-financial-report)

# Note: This example only contains the implementation for the first 'Overview' page of the sample app.

import HTTP, CSV
using Dashboards, DataFrames

external_stylesheets = ["assets/base.css", "assets/base2.css",
                        "assets/base3.css", "assets/styles.css"]

df_fund_facts = CSV.read("data/fund_facts.csv")
df_price_perf = CSV.read("data/price_perf.csv")

function generate_table(df::DataFrame, max_rows = 7)
    html_table() do
        vcat(
            [html_tr(html_th.(names(df)))],
            [
                html_tr() do
                    [html_td(x) for x in df[row, :]]
                end
                for row in 1:min(size(df, 1), max_rows)
            ]
        )
    end
end

app = Dash("Financial Report", external_stylesheets = external_stylesheets, assets_folder="assets") do
    html_div() do
        html_div(id="page-content") do
            html_div(className = "page") do
                # Header
                html_div() do
                    html_div(className = "row") do
                        html_div(className = "row") do
                            html_img(
                                src="assets/dash-financial-logo.png",
                                className="logo",
                            ),
                            html_a(
                                html_button("Learn More", id = "learn-more-button"),
                                href = "#",
                            )
                        end,
                        html_div(className = "twelve columns", style = (padding-left = "0px")) do
                            html_div(className="seven columns main-title") do
                                html_h5("Calibre Financial Index Fund Investor Shares")
                            end,
                            html_div(className="five columns") do
                                dcc_link(
                                    "Full View",
                                    href="#",
                                    className="full-view-link",
                                )
                            end
                        end
                    end,
                    html_br(),
                    html_div(className="row all-tabs") do
                        dcc_link(
                            "Overview",
                            href="#",
                            className="tab first",
                        ),
                        dcc_link(
                            "Price Performance",
                            href="#",
                            className="tab",
                        ),
                        dcc_link(
                            "Portfolio & Management",
                            href="#",
                            className="tab",
                        ),
                        dcc_link(
                            "Fees & Minimums",
                            href="#",
                            className="tab"
                        ),
                        dcc_link(
                            "Distributions",
                            href="#",
                            className="tab",
                        ),
                        dcc_link(
                            "News & Reviews",
                            href="#",
                            className="tab",
                        )
                    end
                end,
                # page 1
                html_div(className = "subpage") do
                    # row 3
                    html_div(className="row") do
                        html_div(className="product") do
                            html_h5("Product Summary"),
                            html_br(),
                            html_p(raw"As the industry’s first index fund for individual investors,
                                the Calibre Index Fund is a low-cost way to gain diversified exposure
                                to the U.S. equity market. The fund offers exposure to 500 of the
                                largest U.S. companies, which span many different industries and
                                account for about three-fourths of the U.S. stock market’s value.
                                The key risk for the fund is the volatility that comes with its full
                                exposure to the stock market. Because the Calibre Index Fund is broadly
                                diversified within the large-capitalization market, it may be
                                considered a core equity holding in a portfolio.",
                                className="row")
                        end
                    end,
                    # row 4
                    html_div(className = "row", style = (margin-bottom = "35px")) do
                        html_div(className = "six columns") do
                            html_h6("Fund Facts", className = "subtitle padded"),
                            generate_table(df_fund_facts)
                        end,
                        html_div(className = "six columns") do
                            html_h6("Average annual performace", className = "subtitle padded"),
                            dcc_graph(
                                id = "graph-1",
                                figure = (
                                    data = [
                                        (
                                            x = ["1 Year", "3 Year", "5 Year", "10 Year", "41 Year"],
                                            y = ["21.67", "11.26", "15.62", "8.37", "11.11"],
                                            type = "bar", name = "Calibre Index Fund"
                                        ),
                                        (
                                            x = ["1 Year", "3 Year", "5 Year", "10 Year", "41 Year"],
                                            y = ["21.83", "11.41", "15.79", "8.50"],
                                            type = "bar", name = "S&P 500 Index"
                                        )
                                    ],
                                    layout = (
                                        title = "",
                                        autosize = false,
                                        height = 200,
                                        hovermode = "closest",
                                        legend = (
                                            x = -0.0228945952895,
                                            y = -0.189563896463,
                                            orientation = "h",
                                            yanchor = "top"
                                        ),
                                        margin = (
                                            r = 0,
                                            t = 20,
                                            b = 10,
                                            l = 10
                                        ),
                                        showLegend = true,
                                        width = 330,
                                        xaxis = (
                                            autorange = true,
                                            range = [-0.5, 4.5],
                                            showline = true,
                                            title = "",
                                            type = "category"
                                        ),
                                        yaxis = (
                                            autorange = true,
                                            range = [0, 22.9789473684],
                                            showgrid = true,
                                            showline = true,
                                            title = "",
                                            type = "linear",
                                            zeroline = false
                                        )
                                    )
                                )
                            )
                        end
                    end,
                    # row 5
                    html_div(className = "row") do
                        html_div(className = "six columns") do
                            html_h6(
                                "Hypothetical growth of \$10,000",
                                className = "subtitle padded"
                            ),
                            dcc_graph(
                                id = "graph-2",
                                figure = (
                                    data = [
                                        (
                                            x = ["2008", "2009", "2010", "2011", "2012",
                                            "2013", "2014", "2015", "2016", "2017", "2018"],
                                            y = ["10000", "7500", "9000", "10000", "10500",
                                                "11000", "14000", "18000", "19000", "20500", "24000"],
                                            type = "Scatter", mode = "lines", name = "Calibre Index Fund Inv"
                                        )
                                    ],
                                    layout = (
                                        autosize = true,
                                        title = "",
                                        height = 200,
                                        width = 340,
                                        hovermode = "closest",
                                        legend = (
                                            x = -0.0277108433735,
                                            y = -0.142606516291,
                                            orientation = "h",
                                        ),
                                        margin = (
                                            r =  20,
                                            t = 20,
                                            b = 20,
                                            l = 50,
                                        ),
                                        showlegend = true,
                                        xaxis = (
                                            autorange = true,
                                            linecolor = "rgb(0, 0, 0)",
                                            linewidth = 1,
                                            range = [2008, 2018],
                                            showgrid = false,
                                            showline = true,
                                            title = "",
                                            type = "linear",
                                        ),
                                        yaxis = (
                                            autorange = false,
                                            gridcolor = "rgba(127, 127, 127, 0.2)",
                                            mirror = false,
                                            nticks = 4,
                                            range = [0, 30000],
                                            showgrid = true,
                                            showline = true,
                                            ticklen = 10,
                                            ticks = "outside",
                                            title = "\$",
                                            type = "linear",
                                            zeroline = false,
                                            zerolinewidth = 4,
                                        )
                                    )
                                )
                            )
                        end,
                        html_div(className = "six columns") do
                            html_h6("Price & Performance", className = "subtitle padded"),
                            generate_table(df_price_perf)
                        end,
                        html_div(className = "six columns") do
                            html_h6("Risk Potential", className = "subtitle padded"),
                            html_img(src = "assets/risk_reward.png", className = "risk-reward")
                        end
                    end
                end
            end
        end
    end
end

handler = make_handler(app, debug = false)
println("started at localhost:8088")
HTTP.serve(handler, HTTP.Sockets.localhost, 8088)
