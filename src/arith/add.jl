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
