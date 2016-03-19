sign{T<:Real}(a::FF{T}) = sign(a.hi)
signbit{T<:Real}(a::FF{T}) = signbit(a.hi)

(-){T<:Real}(a::FF{T}) = FF(-a.hi,-a.lo)
abs{T<:Real}(a::FF{T}) = (a.hi >= zero(T) ? a : -a)

@inline flipsign{T<:Real}(a::FF{T},b::FF{T}) = FF(flipsign(a.hi,b.hi), flipsign(a.lo,b.hi))
@inline flipsign{T<:Real}(a::FF{T},b::Float64) = FF(flipsign(a.hi,b), flipsign(a.lo,b))
@inline flipsign{T<:Real}(a::FF{T},b::Integer) = FF(flipsign(a.hi,b), flipsign(a.lo,b))

@inline function copysign{T<:Real}(a::FF{T},b::Float64)
    if (b < zero(Float64))
        a.hi < zero(Float64) ? a : -a
    else
        a.hi < zero(Float64) ? -a : a
    end
end
copysign{T<:Real}(a::FF{T},b::Integer) = copysign(a,convert(Float64,b))
copysign{T<:Real}(a::FF{T},b::FF{T}) = copysign(a,b.hi)


function frexp{T<:Real}(a::FF{T})
    frhi, xphi = frexp(a.hi)
    frlo, xplo = frexp(a.lo)
    FF(frhi, ldexp(frlo,xplo-xphi)), xphi
end

function ldexp{T<:Real}(a::FF{T},xp::Int)
    FF(ldexp(a.hi,xp),ldexp(a.lo,xp))
end
ldexp{T<:Real,I<:Integer}(fx::Tuple{FF{T},I}) = ldexp(fx...)


