@inline mulby2{T<:Real}(a::T) = a*(one(T)+one(T))

function mulby2{T<:SysFloat}(a::FloatFloat{T})
    FloatFloat{T}(mulby2(a.hi), mulby2(a.lo))
end

function mulpow2{T<:SysFloat,I<:Integer}(a::FloatFloat{T}, powof2::I)
     FloatFloat{T}( ldexp(a.hi, powof2), ldexp(a.lo, powof2) )
end


function (sqr){T<:SysFloat}(a::FloatFloat{T})
  t1,t2 = eftMul(a.hi,a.hi)
  t3 = a.hi * a.lo
  t5 = t3 + t3
  t6 = t2 + t5
  t1,t6 = eftAddGTE(t1,t6)
  FloatFloat{T}(t1,t6)
end

function (*){T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T})
  t1,t2 = eftMul(a.hi,b.hi)
  t3 = a.hi * b.lo
  t4 = a.lo * b.hi
  t5 = t3 + t4
  t6 = t2 + t5
  t1,t6 = eftAddGTE(t1,t6)
  FloatFloat{T}(t1,t6)
end

function (*){T<:SysFloat}(a::FloatFloat{T}, b::T)
  t1,t2 = eftMul(a.hi,b)
  t4 = a.lo * b
  t6 = t2 + t4
  t1,t6 = eftAddGTE(t1,t6)
  FloatFloat{T}(t1,t6)
end

(*){T<:SysFloat}(a::T, b::FloatFloat{T}) = (*)(b,a)

(*){T<:SysFloat,S<:Signed}(a::FloatFloat{T}, b::S) = (*)(a, convert(T,b))
(*){T<:SysFloat,S<:Signed}(a::S, b::FloatFloat{T}) = (*)(convert(T,a), b)

(*){T<:SysFloat,R<:Real}(a::FloatFloat{T}, b::R) = (*)(a, convert(T,b))
(*){T<:SysFloat,R<:Real}(a::R, b::FloatFloat{T}) = (*)(convert(T,a), b)
