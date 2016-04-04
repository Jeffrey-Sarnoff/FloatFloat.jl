function sqrt{T<:Real}(a::FloatFloat{T})
    if a.hi <= zero(T)
       if a.hi == zero(T)
           return zero(FloatFloat{T})
       else
           throw(ArgumentError("sqrt expects a nonnegative base"))
       end
    elseif (a.hi < 1.0e-18) | (a.hi > 1.0e18)
        throw(ArgumentError("sqrt arg ($a) outside domain"))
    end

    if (a.hi < 1.0e-7)  # -log2(1.0e-7) < (1/2) Float64 significand bits
        return one(FloatFloat{T}) / sqrt(one(FloatFloat{T})/a)
    end

    # initial approximation to 1/sqrt(a)
    r = FF(one(T)/sqrt(a.hi), zero(T))

    r = r + divby2( r * (one(FloatFloat{T}) - (a*(r*r))) )
    r = r + divby2( r * (one(FloatFloat{T}) - (a*(r*r))) )
    r = r + divby2( r * (one(FloatFloat{T}) - (a*(r*r))) )

    r = a*r
    divby2(r + a/r)
end


function sqrt{T<:Real}(a:FloatFloat{T})
    hi = sqrt(a.hi)
    t,lo = eftMul(hi,hi)
    lo = (((a.hi - t) - lo) + a.lo) / (2*hi)
    FloatFloat{T}(hi,lo)
end

function hypot{T<:Real}(a::FloatFloat{T}, b::FloatFloat{T})
    a = abs(a)
    b = abs(b)
    t, x = min(a,b), max(a,b)
    t = t/a
    x * sqrt(one(T) + t*t)
end
