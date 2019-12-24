#Necessary packages
import Pkg
Pkg.add("Dashboards")
Pkg.add("PlotlyJS")
Pkg.add("DataFrames")
Pkg.add("HTTP")
Pkg.add("CSV")
Pkg.add("JSON")
Pkg.add("DataFramesMeta")
using Dashboards, PlotlyJS, DataFrames, HTTP, CSV, JSON, DataFramesMeta

external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"]
println("Downloading graph data....")


#Reads csv data from github and saves tp dataframes

#CO2 Emissions per Capita vs. GDP per Capita data (	https://www.esrl.noaa.gov/gmd/ccgg/trends/data.html)
df = CSV.read(
        HTTP.get("https://raw.githubusercontent.com/j-seal/juliaDashboard/master/datasets/co-emissions-per-capita-vs-gdp-per-capita-international-.csv").body
    )
#CO2 Emissions over time data (https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions)
df2 = CSV.read(
        HTTP.get("https://raw.githubusercontent.com/j-seal/juliaDashboard/master/datasets/global-co-concentration-ppm.csv").body
)

#Color scheme for plots
colours = (
    text = "white",
    background = "#363636"
)

#Cleaning up the first dataframe (CO2 emissions vs. GDP per capita) by eliminating missing values and selecting only values from the years 1950+
df = dropmissing(df)
filter!(row -> row[:year] in [1950, 1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015], df)

#Cleans up second dataframe (CO2 emissions over time) by eliminating rows with missing values
df2 = dropmissing(df2)

#Dashboard application constructor (name, external stylesheets)
app = Dash("Environmentalism Dash", external_stylesheets=external_stylesheets) do
    html_div(style = (backgroundColor = colours.background, height = "100%")) do
        #Sets and styles heading/title
        html_h1("Environmental Trends",
            style=(
               textAlign = "center",
               paddingBotton = "0%",
               color = colours.text
            )
        ),
        #First graph (CO2 emissions vs. GDP per capita), complete with slider to view change in data from 1950-Present
        html_div(style = (width="80%", display="inline-block", padding="2% 10%")) do
            dcc_graph(
               id = "graph-with-slider"
            ),
           dcc_slider(
                id = "slider-years",
                min = minimum(df[:,:year]),
                max = maximum(df[:,:year]),
                value = minimum(df[:,:year]),
                marks = Dict([Symbol(v)=>Symbol(v) for v in unique(df[:,:year])]),
                step = nothing,
            )
        end,
        #Second graph (CO2 emissions over time), basic line graph
        html_div(style = (width="80%", display="block", padding="2% 10%")) do
            dcc_graph(
                id = "bar-graph",
                figure= Plot(df2,
                    Layout(
                        xaxis_title = "Year",
                        yaxis_title = "CO2 Concentration in PPM",
                        hovermode = "closest",
                        title = "Atmospheric CO2 Concentration Over Time",
                        height = "40%"
                    ),
                    x = :year,
                    y = :co2_concentration_ppm,
                    mode = "lines+markers",
                    marker_size = 5,
                    marker_line_width = 2,
                    marker_line_color = "orange",
                    marker_color = "orange",
                    marker_opacity = 0.6
                )
            )
        end
    end
end

#Callback for when slider is used, updates the scatterplot based on selected year
callback!(app, callid"slider-years.value => graph-with-slider.figure") do year_picked
    Plot(
        df[df.year .== year_picked, :],
        Layout(
            xaxis_type = "log",
            xaxis_title = "GDP Per Capita",
            yaxis_title = "CO2 Emission per Capita",
            hovermode = "closest",
            title = "CO2 Emission per Capita vs. GDP per Capita",
            height = "40%"
        ),
        x=:gdp_per_capita,
        y=:co2_emissions,
        mode="markers",
        text = :entity,
        marker_size = 10,
        marker_color = "orange",
        marker_opacity = 0.6,
        marker_line_width = 0.5,
        marker_line_color = "white"
    )
end

#Sets up dash at localhost (go to http://127.0.0.1:8080/)
handler = make_handler(app, debug = true)
println("App started at localhost:8080")
HTTP.serve(handler, HTTP.Sockets.localhost, 8080)
