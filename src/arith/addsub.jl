#=
    addition
=#

function (+){T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T})
    s1, s2 = eftAdd(a.hi,b.hi)
    t1, t2 = eftAdd(a.lo,b.lo)
    s2 += t1
    s1, s2 = eftAddGTE(s1,s2)
    s2 += t2
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (+){T<:SysFloat}(a::FloatFloat{T},b::T)
    s1, s2 = eftAdd(a.hi,b)
    s2 += a.lo
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

(+){T<:SysFloat}(a::T, b::FloatFloat{T}) = (+)(b,a)

(+){T<:SysFloat,S<:Signed}(a::FloatFloat{T}, b::S) = (+)(a, convert(T,b))
(+){T<:SysFloat,S<:Signed}(a::S, b::FloatFloat{T}) = (+)(convert(T,a), b)

(+){T<:SysFloat,R<:Real}(a::R, b::FloatFloat{T}) = (+)(convert(T,a), b)
(+){T<:SysFloat,R<:Real}(a::FloatFloat{T}, b::R) = (+)(a, convert(T,b))

#=
function (+){T<:Real}(a::FloatFloat{FloatFloat{T}}, b::FloatFloat{FloatFloat{T}})
    w,x,y,z = eftAdd(a.hi,b.hi,a.lo,b.lo)
    FloatFloat(FloatFloat(w,x), FloatFloat(y,z))
end
=#
    

#=
    subtraction
=#

function (-){T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T})
    s1, s2 = eftSub(a.hi,b.hi)
    t1, t2 = eftSub(a.lo,b.lo)
    s2 += t1
    s1, s2 = eftAddGTE(s1,s2)
    s2 += t2
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (-){T<:SysFloat}(a::FloatFloat{T}, b::T)
    s1, s2 = eftSub(a.hi,b)
    s2 += a.lo
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat(s1,s2)
end

function (-){T<:SysFloat}(a::T, b::FloatFloat{T})
    s1, s2 = eftSub(a,b.hi)
    s2 -= b.lo
    s1, s2 = eftAddGTE(s1,s2)
    FloatFloat{T}(s1,s2)
end

(-){T<:SysFloat,S<:Signed}(a::FloatFloat{T}, b::S) = (-)(a, convert(T,b))
(-){T<:SysFloat,S<:Signed}(a::S, b::FloatFloat{T}) = (-)(convert(T,a), b)

(-){T<:SysFloat,R<:Real}(a::R, b::FloatFloat{T}) = (-)(convert(T,a), b)
(-){T<:SysFloat,R<:Real}(a::FloatFloat{T}, b::R) = (-)(a, convert(T,b))
