#=
    addition
=#

function (+){T<:Real}(a::FloatFloat{T}, b::FloatFloat{T{)
    s1, s2 = eftAdd(a.hi,b.hi)
    t1, t2 = eftAdd(a.lo,b.lo)
    s2 += t1
    s1, s2 = eftAddGTE(s1,s2)
    s2 += t2
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (+){T<:Real}(a::FloatFloat{T},b::T)
    s1, s2 = eftAdd(a.hi,b)
    s2 += a.lo
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

(+){T<:Real}(a::T, b::FloatFloat{T}) = (+)(b,a)
(+){T<:Real}(a::FloatFloat{T}, b::Signed) = (+)(a,convert(T,b))
(+){T<:Real}(a::Signed, b::FloatFloat{T}) = (+)(b,a)

(+){T<:Real}(a::Real, b::FloatFloat{T}) = (+)(convert(T,a), b)
(+){T<:Real}(a::FloatFloat{T}, b::Real) = (+)(a, convert(T,b))

#=
    subtraction
=#

function (-){T<:Real}(a::FloatFloat{T}, b::FloatFloat{T})
    s1, s2 = eftSub(a.hi,b.hi)
    t1, t2 = eftSub(a.lo,b.lo)
    s2 += t1
    s1, s2 = eftAddGTE(s1,s2)
    s2 += t2
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (-){T<:Real}(a::FloatFloat{T}, b::T)
    s1, s2 = eftSub(a.hi,b)
    s2 += a.lo
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (-){T<:Real}(a::T, b::FloatFloat{T})
    s1, s2 = eftSub(a,b.hi)
    s2 -= b.lo
    s1, s2 = eftAddGTE(s1,s2)
    DD(s1,s2)
end

(-){T<:Real}(a::FloatFloat{T}, b::Signed) = (-)(a, convert(T,b))
(-){T<:Real}(a::Signed, b::FloatFloat{T}) = (-)(convert(T,a), b)

(-){T<:Real}(a::Real, b::FloatFloat{T}) = (-)(convert(T,a), b)
(-){T<:Real}(a::FloatFloat{T}, b::Real) = (-)(a, convert(T,b))