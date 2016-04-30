immutable FloatFloat{T<:SysFloat} <: Real
    hi::T      # high order part (precision T)
    lo::T      # low  order part, extended precision
               # wash away autogenerated constructors 
    FloatFloat{T}(hi::T, lo::T) = new(hi,lo)         # new should not be parameterized
end

# matching an external constructor to the parameterized internal constructor is necessary
FloatFloat{T<:SysFloat}(hi::T, lo::T) = FloatFloat{T}(hi,lo) # the RHS must be parameterized

# more robust external construction
FloatFloat{T<:SysFloat}(hi::T) = FloatFloat(hi,zero(T)) # the RHS should not be parameterized

#  define explicit conversions for faster immutable type construction
convert{T<:SysFloat}(::Type{FloatFloat{T}}, hi::T, lo::T) = FloatFloat{T}(hi, lo)
convert{T<:SysFloat}(::Type{FloatFloat{T}}, hi::T)        = FloatFloat{T}(hi, zero(T))

# construction using other numeric types

for (T1,T2) in ((:Integer,:Integer),(:Integer,:Rational),
                (:Rational,:Integer),(:Rational,:Rational))
  @eval begin
    function FloatFloat(hi::($T1), lo::($T2))
        a,b = promote(hi,lo)
        FloatFloat(AbstractFloat(a), AbstractFloat(b))
    end
  end
end  

for T in (:Float64, :Float32)
  for (T1,T2) in ((:Integer,T),(T,:Integer),(:Rational,T),(T,:Rational))
    @eval begin
      function FloatFloat(hi::($T1), lo::($T2))
        a,b = promote(hi,lo)
        FloatFloat(AbstractFloat(a), AbstractFloat(b))
      end    
    end
  end
end  


# a type specific hash function helps the type to 'just work'
const hash_floatfloat_lo = (UInt === UInt64) ? 0x086540d7a5325bc3 : 0x5acda43c
const hash_0_floatfloat_lo = hash(zero(UInt), hash_ff_lo)
hash{T<:Real}(z::FloatFloat{T}, h::UInt) = 
    hash(z.hi, (h $ hash(z.lo, hash_floatfloat_lo) $ hash_0_floatfloat_lo))
