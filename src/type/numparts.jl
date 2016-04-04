sign{T<:Real}(a::FloatFloat{T}) = sign(a.hi)
@inline signbit{T<:Real}(a::FloatFloat{T}) = signbit(a.hi)

#=
    negation, abs, flipsign, copysigb
=#

@inline (-){T<:Real}(a::FloatFloat{T}) = FloatFloat{T}(-a.hi, -a.lo)
@inline abs{T<:Real}(a::FloatFloat{T}) = ifelse(signbit(a.hi), -a, a)

flipsign{T<:Real}(a::FloatFloat{T}, b::FloatFloat{T}) = ifelse(signbit(b.hi), -a, a)
flipsign{T1<:Real,T2<:Real}(a::FloatFloat{T1}, b::T2) = ifelse(signbit(b), -a, a)
copysign{T<:Real}(a::FloatFloat{T}, b::FloatFloat{T}) = ifelse(signbit(b.hi), -abs(a), abs(a))
copysign{T1<:Real,T2<:Real}(a::FloatFloat{T1}, b::T2) = ifelse(signbit(b), -abs(a), abs(a))


#=
    frexp, ldexp, zero, one
=#

function frexp{T<:Real}(a::FloatFloat{T})
    frhi, xphi = frexp(a.hi)
    frlo, xplo = frexp(a.lo)
    FloatFloat(frhi, ldexp(frlo,xplo-xphi)), xphi
end

function ldexp{T<:Real}(a::FloatFloat{T},xp::Int)
    FloatFloat(ldexp(a.hi,xp),ldexp(a.lo,xp))
end
ldexp{T<:Real,I<:Integer}(fx::Tuple{FloatFloat{T},I}) = ldexp(fx...)


zero{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(zero(T), zero(T))
one{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(one(T), zero(T))
zero{T<:Real}(x::FloatFloat{T}) = zero(FloatFloat{T})
one{T<:Real}(x::FloatFloat{T}) = one(FloatFloat{T})

# Inf, NaN

InfFF{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(Inf(T), Inf(T))
NaNFF{T<:Real}(::Type{FloatFloat{T}}) = FloatFloat(NaN(T), NaN(T))
