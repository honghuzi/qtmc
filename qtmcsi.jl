addprocs()
include("parameter.jl")
include("equations.jl")
include("initx.jl")
include("init.jl")
include("evolution.jl")

using Init
using Evolu

#@time Initial()
@time Evolution()
