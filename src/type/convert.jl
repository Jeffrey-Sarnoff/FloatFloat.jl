convert{T<:Real}(::Type{FloatFloat{T}}, x::T) = FloatFloat{T}(x,zero(T))
convert{T<:Real}(::Type{T}, x::FloatFloat{T}) = x.hi

convert{T<:Real}(::Type{FloatFloat{T}}, x::Real) = FloatFloat{T}(convert(T,x),zero(T))
convert{T1<:Real, T2<:Real}(::Type{T1}, x::FloatFloat{T2}) = (T1)(x.hi)

convert{T1<:Real, T2<:Real}(::Type{FloatFloat{T1}}, x::FloatFloat{T2}) = 
    FloatFloat{T1}(convert(T1,x.hi), convert(T1,x.lo))


function convert{T<:Real}(::Type{BigFloat}, x::FloatFloat{T})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end

function convert{T<:Real}(::Type{FloatFloat{T}}, x::BigFloat)
    hi = (T)(x)
    lo = (T)(x - hi)
    FloatFloat{T}(hi,lo)
end

function convert{T1<:Real, T2<:Real}(::Type{T1}, x::FloatFloat{T2})
   bf = convert(BigFloat, x)
   convert(T1, bf)
end

function convert{T1<:Real, T2<:Real}(::Type{FloatFloat{T1}}, x::T2)
   bf = convert(BigFloat, x)
   convert(FloatFloat{T1}, bf)
end



function convert{T<:Real}(::Type{BigFloat}, x::FloatFloat{FloatFloat{T}})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end

function convert{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, x::BigFloat)

function convert{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, x::BigFloat)
    hi = convert(FloatFloat{T}, x)
    y  = x - convert(BigFloat, hi)
    lo = convert(FloatFloat{T}, y)
    FloatFloat{FloatFloat{T}}(hi,lo)
end
end

promote_rule{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{FloatFloat{T}}) = 
    FloatFloat{FloatFloat{T}}

promote_rule{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{BigFloat}) = BigFloat
    
