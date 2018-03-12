@everywhere module Parameter

export ne, E0, A0, T, TT, N_cycle, Ip, omega, z, a1, a2, a3, a4, a5, a6
export GetEleField

const c = 3e8
const I_si = 0.75e14
const lambda = 795.0e-9
const omega_si = 2pi*c/ lambda
const E_si = 2.742e3*sqrt(I_si)

const omega = omega_si * 2.4189e-17
const E0 = E_si/5.1421e11
const A0 = E0/omega
const T = 2pi/omega

const Ip = -0.4458
const z = 1.0
const a1, a2, a3, a4, a5, a6 = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

const ne = Int(1.5e6)
#const s1, s2 = 0.707^2, 0.582^2
const vper = sqrt(abs(E0)/ sqrt(2.0*abs(Ip)))

const N_cycle = 6
const N1, N2, N3 = 2, 4, 2
const TT = N_cycle*T


@inline function GetEleField(t::Float64)
    envelope = t < N1*T ? sin(0.5pi*t/N1/T)^2 :
                t < (N1+N2)*T ? 1:
                t < (N1+N2+N3)*T ? cos(0.5pi*(t-(N1-N2)*T)/N3/T)^2 : 0
    envelope*cos(omega*t)*E0
end

end
