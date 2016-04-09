immutable FloatFloat{T<:Real} <: Real
    hi::T    # high order part, precision is precision of T 
    lo::T    # low  order part, extended precision
              # wash away autogenerated constructors 
    FloatFloat{T}(hi::T, lo::T) = new(hi,lo)         # new should not be parameterized
end

immutable FloatFloat{T<:Real} <: Real
    hi::T    # high order part (precision T)
    lo::T    # low  order part, extended precision
              # wash away autogenerated constructors 
    FloatFloat{T}(hi::T, lo::T) = new(hi,lo)         # new should not be parameterized
end


# matching an external constructor to the parameterized internal constructor is necessary
FloatFloat{T<:Real}(hi::T, lo::T) = FloatFloat{T}(hi,lo)
# augment external construction
FloatFloat{T<:Real}(hi::T) = FloatFloat{T}(hi,zero(T))

typealias IntRat     Union{Integer,Rational}
typealias IntRatFlt  Union{Float64,Float32,Float16,Integer,Rational}

# handle other reasonable inputs; allows e.g. FloatFloat(100,eps(100.0)/4)
function FloatFloat{T1<:IntRatFlt, T2<:IntRatFlt}(hi::T1, lo::T2)
    a,b = promote(hi,lo)
    if (isa(a, Integer) | isa(a, Rational))
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


const hash_ff_lo = (UInt === UInt64) ? 0x086540d7a5325bc3 : 0x5acda43c
const hash_0_ff_lo = hash(zero(UInt), hash_ff_lo)
hash{T<:Real}(z::FloatFloat{T}, h::UInt) = 
    hash(z.hi, (h $ hash(z.lo, hash_ff_lo) $ hash_0_ff_lo))
