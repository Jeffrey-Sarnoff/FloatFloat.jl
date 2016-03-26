immutable FloatFloat{T<:Real} <: Real
    hi::T    # high order part, precision of type T 
    lo::T    # low  order part, extended precision
    
    FloatFloat{T}(hi::T, lo::T) = new(hi,lo)
end

# use FloatFloat when it is known that (hi, lo) == eftAdd(hi,lo)
#
# matching to the internal constructor
FloatFloat{T<:Real}(hi::T, lo::T) = FloatFloat{T}(hi,lo)
# augmenting external construction
FloatFloat{T<:Real}(hi::T) = FloatFloat{T}(hi,zero(T))
# handle other reasonable inputs; allows e.g. FloatFloat(100,eps(100.0)/4)
function FloatFloat{T1<:Real, T2<:Real}(hi::T1, lo::T2)
    a,b = promote(hi,lo)
    if typeof(a) <: Integer
       FloatFloat(float(hi), float(lo))
    else
       FloatFloat(a,b)
    end
end    

#  define explicit conversions for faster immutable type construction
convert{T<:Real}(::Type{FloatFloat{T}}, hi::T, lo::T) = FloatFloat{T}(hi, lo)
convert{T<:Real}(::Type{FloatFloat{T}}, hi::T)        = FloatFloat{T}(hi, zero(T))
#  support generalized conversions over FloatFloat type parameter
convert{T<:Real}(::Type{FloatFloat}, hi::T, lo::T) = FloatFloat{T}(hi, lo)
convert{T<:Real}(::Type{FloatFloat}, hi::T)        = FloatFloat{T}(hi, zero(T))


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



