function recip{T<:Real}(b::FloatFloat{T})
  q1 = one(T) / b.hi
  r  = one(T) - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftSum3to2(q1,q2,q3)
  FloatFloat(q1,q2)
end

function (/){T<:Real}(a::FloatFloat{T}, b::FloatFloat{T})
  q1 = a.hi / b.hi
  r  = a - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftSum3to2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

function (/){T<:Real}(a::FloatFloat{T}, b::T)
  q1 = a.hi / b
  r  = a - (q1 * b)

  q2 = r.hi / b
  r = r - (q2 * b)

  q3 = r.hi / b

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftSum3to2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

function (/){T<:Real}(a::T, b::FloatFloat{T})
  q1 = a / b.hi
  r  = a - (q1 * b)

  q2 = r.hi / b.hi
  r = r - (q2 * b)

  q3 = r.hi / b.hi

  q1,q2 = eftAddGTE(q1, q2)
  q1,q2 = eftSum3to2(q1,q2,q3)
  
  FloatFloat(q1,q2)
end

(/){T1<:Real, T2<:Real}(a::FloatFloat{T1}, b::T2) = (/)(a, convert(T1,b))
(/){T1<:Real, T2<:Real}(a::T1, b::FloatFloat{T2}) = (/)(convert(T2,a), b)