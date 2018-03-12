module Init

using Parameter, Initx, JLD

export Initial

function InitWeight(ele, p)
    w0 = ( (((2*Ip)^2)/abs(ele))^(2/sqrt(2*abs(Ip))-1) ) * exp( -2 *( sqrt(2*abs(Ip))^3 )/3/abs(ele) )
    w1 = sqrt( 2*abs(Ip) )/abs(ele) * exp( -(p^2) * sqrt(2*abs(Ip)) / abs(ele) )
    w = w0*w1
end

function Initial()
    ti = zeros(ne)
    px = zeros(ne)
    ele = zeros(ne)
    y = zeros(ne)
    w = zeros(ne)
    vper = sqrt( E0/sqrt(2.0*abs(Ip)) )

    for i in 1:ne
        gamma = 10.0
        while (gamma > 5.0)
            ti[i] = rand()*N_cycle*T
            ele[i] = GetEleField(ti[i])
            Up = ((ele[i]/omega)^2)/4

            gamma = sqrt(abs(Ip)/2Up)
        end
        y[i] = Getx(ele[i])
        px[i] = 5vper * (2rand() - 1)
        w[i] = InitWeight(ele[i], abs(px[i]));
    end
    save("data/init.jld", "ti", ti, "px", px, "y", y, "w", w)
    # nbins = 500
    # height, bins = np.histogram(px, nbins,  weights=w)
    # height = height/maximum(height)
    # plot(bins[1:end-1], height)
    # show()
end

end
