@everywhere module Evolu

using Parameter, Equas, JLD
using DifferentialEquations
#using ODEInterfaceDiffEq
#using LSODA

export Evolution

function Evolution()
  ti = load("data/init.jld")["ti"]
  px = load("data/init.jld")["px"]
  y = load("data/init.jld")["y"]
  w = load("data/init.jld")["w"]
  x = zeros(ne)
  py = zeros(ne)
  act = zeros(ne)
  u0 =  zeros(5)

  prob = ODEProblem(Eq, u0, (0, TT)) #Dummy allocate u0

  function prob_func(prob, i)
    prob.u0 = [0.0, y[i], px[i], 0.0, 0.0]
    prob.tspan = (ti[i], TT)
    # if mod(i, Int(2e4)) == 0
    #   println("i=$(i)")
    # end
    prob
  end

  monte_prob = MonteCarloProblem(prob, prob_func=prob_func)
  sim = solve(monte_prob, Tsit5(), num_monte=ne, parallel_type=:threads; save_everystep=false, dense=false, force_dtmin=true)
  #sim = solve(monte_prob, Tsit5(), num_monte=50000; save_everystep=false, dense=false, force_dtmin=true)
  for i in 1:ne
    x[i], y[i], px[i], py[i], act[i] = sim[2, i]
  end
  save("data/fs.jld", "x", x, "y", y, "px", px, "py", py, "act", act, "ti", ti, "w", w)
  nothing
end



end
