convert{T<:Real}(::Type{FloatFloat{T}}, x::T) = FloatFloat{T}(x,zero(T))
convert{T<:Real}(::Type{T}, x::FloatFloat{T}) = x.hi

convert{T<:Real}(::Type{FloatFloat{T}}, x::Real) = FloatFloat{T}(convert(T,x),zero(T))
convert{T1<:Real, T2<:Real}(::Type{T1}, x::FloatFloat{T2}) = (T1)(x.hi)

convert{T1<:Real, T2<:Real}(::Type{FloatFloat{T1}}, x::FloatFloat{T2}) = 
    FloatFloat{T1}(convert(T1,x.hi), convert(T1,x.lo))
