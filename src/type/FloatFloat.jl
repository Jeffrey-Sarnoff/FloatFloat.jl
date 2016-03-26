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
       FloatFloat{typeof(a)}(a,b)
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
function FF{T<:Real}(hi::T, lo::T) 
  high = hi + lo
  t = high - hi
  low = (hi - (high - t)) + (lo - t)
  FloatFloat(high,low)
end
FF{T<:Real}(hi::T) = FloatFloat{T}(hi,zero(T))
function FF{T1<:Real, T2<:Real}(hi::T1, lo::T2)
    a,b = promote(hi,lo)
    if typeof(a) <: Integer
        FF(float(hi), float(lo))
    else
        FF(a,b)
    end
end    


# use convert to ensure magnitude(hi) >= magnitude(lo)
#
convert{T<:Real}(::Type{FloatFloat{T}}, a::T, b::T) = 
   ifelse(abs(a)>abs(b), FloatFloat(a,b), FloatFloat(b,a))
# augment external conversion; allows e.g. convert(FloatFloat, Float32(a), Float32(b))
convert{T<:Real}(::Type{FloatFloat}, a::T, b::T) = convert(FloatFloat{T}, a, b)
# convert other reasonable inputs; allows e.g. convert(FloatFloat, Int32(a), Float64(b))
convert{T1<:Real, T2<:Real}(::Type{FloatFloat}, a::T1, b::T2) = convert(FloatFloat, promote(a,b)...)




