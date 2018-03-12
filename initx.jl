module Initx
using Parameter: Ip

export Getx

function Getx(ele)
    eta = ele < 0 ? -Eta_Turning_Point(-ele) : Eta_Turning_Point(ele)
    -eta/2
end

function Eta_Turning_Point(ele::Float64)
    w   = ( -1.0 + sqrt(3)*im )/2
    w_2 = ( -1.0 - sqrt(3)*im )/2
    p = -4/3*( (Ip/ele)^2 ) + 2/ele
    q = 16/27*( (Ip/ele)^3 ) - 4/3*Ip/(ele^2) + 1/ele

    delta = (q/2)^2+(p/3)^3
    # ==== only one solution:
    if delta>=0
        s = sqrt(delta)
        eta1 = Complex(-q/2+s)^(1/3) + Complex(-q/2-s)^(1/3) - 2/3*Ip/ele
        eta2 = 0 # over barrier ionization
        eta3 = 0 # over barrier ionization
        eta  = 0

        # # ==== three solutions:
    else
        c_s = im*sqrt(-delta)
        eta1 = Complex(-q/2+c_s)^(1/3)  + Complex(-q/2-c_s)^(1/3)   - 2/3*Ip/ele
        eta2 = w * Complex(-q/2+c_s)^(1/3) + w_2 * Complex(-q/2-c_s)^(1/3)  - 2/3*Ip/ele
        eta3 = w_2 * Complex(-q/2+c_s)^(1/3) + w * Complex(-q/2-c_s)^(1/3)  - 2/3*Ip/ele
        if ele>0
            eta = max(abs(eta1), abs(eta2), abs(eta3))
        else
            eta =-max(abs(eta1), abs(eta2), abs(eta3))
        end
    end
    eta
end

end
