# use FF when it is not known that (hi,lo) == eftAdd(hi,lo)
#
function FF{T<:StdFloat}(hi::T, lo::T) 
  high = hi + lo
  t = high - hi
  low = (hi - (high - t)) + (lo - t)
  FloatFloat(high,low)
end
FF{T<:StdFloat}(hi::T) = FloatFloat{T}(hi,zero(T))
function FF{T1<:StdFloat, T2<:StdFloat}(hi::T1, lo::T2)
    a,b = promote(hi,lo)
    FF(a,b)
end    
FF{F<:StdFloat, I<:Integer}(hi::F, lo::I) = FF(promote(hi,lo)...)
FF{F<:StdFloat, I<:Integer}(hi::I, lo::F) = FF(promote(hi,lo)...)
FF{I1<:Integer, I2<:Integer}(hi::I1, lo::I2) = FF(promote(float(hi),float(lo))...)

function FF{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T}) 
    w,x,y,z = eftAdd(a.hi,a.lo,b.hi,b.lo)
    FloatFloat{FloatFloat{T}}(FloatFloat{T}(w,x), FloatFloat{T}(y,z))
end    



FF128{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float64(hi),Float64(lo))
FF64{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float32(hi),Float32(lo))
FF32{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float16(hi),Float16(lo))
FF128{T<:Real}(hi::T) = FloatFloat{Float64}(Float64(hi))
FF64{T<:Real}(hi::T) = FloatFloat{Float32}(Float32(hi))
FF32{T<:Real}(hi::T) = FloatFloat{Float16}(Float16(hi))
