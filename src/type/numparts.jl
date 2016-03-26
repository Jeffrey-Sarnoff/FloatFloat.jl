sign{T<:Real}(a::FloatFloat{T}) = sign(a.hi)
signbit{T<:Real}(a::FloatFloat{T}) = signbit(a.hi)

(-){T<:Real}(a::FloatFloat{T}) = FF(-a.hi,-a.lo)
abs{T<:Real}(a::FloatFloat{T}) = (a.hi >= zero(T) ? a : -a)

@inline flipsign{T<:Real}(a::FloatFloat{T},b::FloatFloat{T}) = 
   FloatFloat(flipsign(a.hi,b.hi), flipsign(a.lo,b.hi))
@inline flipsign{T<:Real}(a::FloatFloat{T},b::Float64) = 
   FloatFloat(flipsign(a.hi,b), flipsign(a.lo,b))
@inline flipsign{T<:Real}(a::FloatFloat{T},b::Integer) = 
   FloatFloat(flipsign(a.hi,b), flipsign(a.lo,b))

@inline function copysign{T<:Real}(a::FloatFloat{T},b::Float64)
    if (b < zero(Float64))
        a.hi < zero(Float64) ? a : -a
    else
        a.hi < zero(Float64) ? -a : a
    end
end
copysign{T<:Real}(a::FloatFloat{T},b::Integer) = copysign(a,convert(Float64,b))
copysign{T<:Real}(a::FloatFloat{T},b::FloatFloat{T}) = copysign(a,b.hi)


function frexp{T<:Real}(a::FloatFloat{T})
    frhi, xphi = frexp(a.hi)
    frlo, xplo = frexp(a.lo)
    FF(frhi, ldexp(frlo,xplo-xphi)), xphi
end

function ldexp{T<:Real}(a::FloatFloat{T},xp::Int)
    FF(ldexp(a.hi,xp),ldexp(a.lo,xp))
end
ldexp{T<:Real,I<:Integer}(fx::Tuple{FloatFloat{T},I}) = ldexp(fx...)



zero{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(zero(T), zero(T))
one{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(one(T), zero(T))
zero{T<:Real}(x::FloatFloat{T}) = zero(FloatFloat{T})
one{T<:Real}(x::FloatFloat{T}) = one(FloatFloat{T})

InfFF{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(Inf(T), Inf(T))
NaNFF{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(NaN(T), NaN(T))
