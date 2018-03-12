@everywhere module Equas
using Parameter

export Eq

function Eq(t, u, du)
    r = sqrt(u[1]^2 +u[2]^2)

    ele = GetEleField(t)

    du[1] = u[3]
    du[2] = u[4]

    du[3] = -u[1]*( z + a1*(1.0+a2*r)*exp(-a2*r) + a3*a4*r^2*exp(-a4*r) + a5*(1.0+a6*r)*exp(-a6*r))/(r^3)
    du[4] = -u[2]*( z + a1*(1.0+a2*r)*exp(-a2*r) + a3*a4*r^2*exp(-a4*r) + a5*(1.0+a6*r)*exp(-a6*r))/(r^3) - ele
    du[5] = 0.5*(u[3]^2+u[4]^2) - (z + a1*exp(-a2*r) + a3*r*exp(-a4*r) + a5*exp(-a6*r)) / r
end

end
