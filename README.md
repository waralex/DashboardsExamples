Examples for [Dashboards.jl](https://github.com/waralex/Dashboards)

# Running an example 
You would need to run `julia <path_to_example>`. All examples listen to `localhost:8080`.

Once you run the example, open a web browser and go to `http://127.0.0.1:8080` in order to see your Dashboard. 

# List of examples

## Dash tutorial
The `dash_tutorial` folder contains examples from [Dash tutorial](https://dash.plot.ly/) implemented on Dashboards.jl.

File naming: ``<section number in the tutorial>_<section name>_<serial number of the example in this section>``.

For example, `3_basic_dash_callbacks_3.jl` is the implementation of the third dashboard in [this tutorial page](https://dash.plot.ly/getting-started-part-2)

All examples depends on Dashboards.jl and HTTP.jl. Some examples also depends on DataFrames.jl, CSV.jl, PlotlyBase.jl, JSON.jl and JSON2.jl
