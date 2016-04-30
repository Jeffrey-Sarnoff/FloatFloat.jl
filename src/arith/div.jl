@inline divby2{T<:Real}(a::T) = a*0.5

function divby2{T<:SysFloat}(a::FloatFloat{T})
    FloatFloat{T}(divby2(a.hi), divby2(a.lo))
end

function divpow2{T<:SysFloat,I<:Integer}(a::FloatFloat{T}, powof2::I)
     FloatFloat{T}( ldexp(a.hi, -powof2), ldexp(a.lo, -powof2) )
end


function inv{T<:SysFloat}(b::FloatFloat{T})
  q1 = one(T) / b.hi
  r  = one(T) - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftAddAs2(q1,q2,q3)
  FloatFloat(q1,q2)
end

function (/){T<:SysFloat}(a::FloatFloat{T}, b::FloatFloat{T})
  q1 = a.hi / b.hi
  r  = a - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftAddAs2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

function (/){T<:SysFloat}(a::FloatFloat{T}, b::T)
  q1 = a.hi / b
  r  = a - (q1 * b)

  q2 = r.hi / b
  r = r - (q2 * b)

  q3 = r.hi / b

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftAddAs2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

function (/){T<:SysFloat}(a::T, b::FloatFloat{T})
  q1 = a / b.hi
  r  = a - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftAddAs2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

(/){T<:SysFloat,S<:Signed}(a::FloatFloat{T}, b::T) = (/)(a, convert(T1,b))
(/){T<:SysFloat,S<:Signed}(a::S, b::FloatFloat{T}) = (/)(convert(T2,a), b)

(/){T<:SysFloat,R<:Real}(a::FloatFloat{T}, b::R) = (/)(a, convert(T1,b))
(/){T<:SysFloat,R<:Real}(a::R, b::FloatFloat{T}) = (/)(convert(T2,a), b)
