sign{T<:SysFloat}(a::FloatFloat{T}) = sign(a.hi)
@inline signbit{T<:SysFloat}(a::FloatFloat{T}) = signbit(a.hi)

#=
    negation, abs, flipsign, copysigb
=#

@inline (-){T<:SysFloat}(a::FloatFloat{T}) = FloatFloat{T}(-a.hi, -a.lo)
@inline abs{T<:SysFloat}(a::FloatFloat{T}) = ifelse(signbit(a.hi), -a, a)

flipsign{T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = ifelse(signbit(b.hi), -a, a)
flipsign{T1<:SysFloat,T2<:Real}(a::FloatFloat{T1}, b::T2) = ifelse(signbit(b), -a, a)
copysign{T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = ifelse(signbit(b.hi), -abs(a), abs(a))
copysign{T1<:SysFloat,T2<:Real}(a::FloatFloat{T1}, b::T2) = ifelse(signbit(b), -abs(a), abs(a))


#=
    frexp, ldexp
=#

function frexp{T<:SysFloat}(a::FloatFloat{T})
    frhi, xphi = frexp(a.hi)
    frlo, xplo = frexp(a.lo)
    FloatFloat(frhi, ldexp(frlo,xplo-xphi)), xphi
end

function ldexp{T<:SysFloat}(a::FloatFloat{T},xp::Int)
    FloatFloat(ldexp(a.hi,xp),ldexp(a.lo,xp))
end
ldexp{T<:SysFloat,I<:Integer}(fx::Tuple{FloatFloat{T},I}) = ldexp(fx...)


#=
    modf, fmod
=#

function modf{T<:SysFloat}(a::FloatFloat{T})
   fhi, ihi = modf(a.hi)
   flo, ilo = modf(a.lo)
   f = FloatFloat{T}(fhi)+FloatFloat{T}(flo)
   i = FloatFloat{T}(ihi)+FloatFloat{T}(ilo)
   f,i
end

function fmod{T<:SysFloat}(fracpart::FloatFloat{T}, intpart::FloatFloat{T})
   intpart + fracpart
end

# zero, one

zero{T<:SysFloat}(::Type{FloatFloat{T}}) = FloatFloat(zero(T), zero(T))
one{T<:SysFloat}(::Type{FloatFloat{T}}) = FloatFloat(one(T), zero(T))
zero{T<:SysFloat}(x::FloatFloat{T}) = zero(FloatFloat{T})
one{T<:SysFloat}(x::FloatFloat{T}) = one(FloatFloat{T})

# epsilon -- These functions return values of type T, not type FloatFloat{T}

eps{T<:SysFloat}(x::FloatFloat{T}) = eps( ifelse(x.lo == zero(T), x.hi, x.lo) )
ulp{T<:SysFloat}(x::FloatFloat{T}) = eps( x ) * 0.5


# Inf, NaN

InfFF{T<:SysFloat}(::Type{FloatFloat{T}}) = FloatFloat(Inf(T), Inf(T))
NaNFF{T<:SysFloat}(::Type{FloatFloat{T}}) = FloatFloat(NaN(T), NaN(T))
InfFF{T<:SysFloat}(x::FloatFloat{T}) = InfFF(FloatFloat{T})
NaNFF{T<:SysFloat}(x::FloatFloat{T}) = NaNFF(FloatFloat{T})
