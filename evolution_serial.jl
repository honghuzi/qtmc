module Evolu

using Parameter, Equas, DifferentialEquations, JLD

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
    for i in 1:500000
        prob = ODEProblem(Eq, u0, (ti[i], 100.0)) #Dummy allocate u0
        prob.u0[1] = x[i]; prob.u0[2] = y[i]; prob.u0[3] = px[i]; prob.u0[4] = py[i]; prob.u0[5] = act[i] #Best to not allocate
        sol = solve(prob; save_everystep=false, dense=false)#, parallel_type=:threads) # Only need solution at the end
        x[i] = sol.u[2][1]
        y[i] = sol.u[2][2]
        px[i] = sol.u[2][3]
        py[i] = sol.u[2][4]
        act[i] = sol.u[2][5]
        if mod(i, Int(2e4)) == 0
            println("i=$(i)")
        end
    end
    println("end")
    save("data/fs.jld", "x", x, "y", y, "px", px, "py", py, "act", act, "ti", ti, "w", w)
end

end
