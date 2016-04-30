
#  define explicit conversions for faster immutable type construction
convert{T<:Real}(::Type{T}, x::FloatFloat{T}) = x.hi

convert{T<:Real}(::Type{FloatFloat{T}}, x::Real) = FloatFloat{T}(convert(T,x),zero(T))
convert{T1<:Real, T2<:Real}(::Type{T1}, x::FloatFloat{T2}) = (T1)(x.hi)

convert{T1<:Real, T2<:Real}(::Type{FloatFloat{T1}}, x::FloatFloat{T2}) = 
    FloatFloat{T1}(convert(T1,x.hi), convert(T1,x.lo))


function convert{T<:Real}(::Type{BigFloat}, x::FloatFloat{T})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end

function convert{T<:Real}(::Type{FloatFloat{T}}, x::BigFloat)
    hi = (T)(x)
    lo = (T)(x - hi)
    FloatFloat{T}(hi,lo)
end

function convert{T1<:Real, T2<:Real}(::Type{T1}, x::FloatFloat{T2})
   bf = convert(BigFloat, x)
   convert(T1, bf)
end

function convert{T1<:Real, T2<:Real}(::Type{FloatFloat{T1}}, x::T2)
   bf = convert(BigFloat, x)
   convert(FloatFloat{T1}, bf)
end



function convert{T<:Real}(::Type{BigFloat}, x::FloatFloat{FloatFloat{T}})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end


function convert{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, x::BigFloat)
    hi = convert(FloatFloat{T}, x)
    y  = x - convert(BigFloat, hi)
    lo = convert(FloatFloat{T}, y)
    FloatFloat{FloatFloat{T}}(hi,lo)
end


promote_rule{T<:Real}(::Type{T}, ::Type{FloatFloat{T}}) = FloatFloat{T}
promote_rule{T<:Real,R<:Real}(::Type{R}, ::Type{FloatFloat{T}}) = FloatFloat{T}
promote_rule{T<:Real,I<:Integer}(::Type{I}, ::Type{FloatFloat{T}}) = FloatFloat{T}

promote_rule{T<:Real}(::Type{BigFloat}, ::Type{FloatFloat{T}}) = FloatFloat{T}

promote_rule{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{FloatFloat{T}}) = 
    FloatFloat{FloatFloat{T}}

promote_rule{T<:Real}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{BigFloat}) = BigFloat
    



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
