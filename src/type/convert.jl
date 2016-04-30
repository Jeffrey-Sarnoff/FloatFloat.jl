

function convert{T<:SysFloat}(::Type{BigFloat}, x::FloatFloat{T})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end

function convert{T<:SysFloat}(::Type{FloatFloat{T}}, x::BigFloat)
    hi = (T)(x)
    lo = (T)(x - hi)
    FloatFloat{T}(hi,lo)
end

function convert{T1<:Real, T2<:SysFloat}(::Type{T1}, x::FloatFloat{T2})
   bf = convert(BigFloat, x)
   convert(T1, bf)
end

function convert{T1<:SysFloat, T2<:Real}(::Type{FloatFloat{T1}}, x::T2)
   bf = convert(BigFloat, x)
   convert(FloatFloat{T1}, bf)
end



#=
promote_rule{T<:SysFloat}(::Type{T}, ::Type{FloatFloat{T}}) = FloatFloat{T}
promote_rule{T<:SysFloat,R<:Real}(::Type{R}, ::Type{FloatFloat{T}}) = FloatFloat{T}
promote_rule{T<:SysFloat,I<:Integer}(::Type{I}, ::Type{FloatFloat{T}}) = FloatFloat{T}

promote_rule{T<:SysFloat}(::Type{BigFloat}, ::Type{FloatFloat{T}}) = FloatFloat{T}

promote_rule{T<:SysFloat}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{FloatFloat{T}}) = 
    FloatFloat{FloatFloat{T}}

function convert{T<:SysFloat}(::Type{BigFloat}, x::FloatFloat{FloatFloat{T}})
   hi = BigFloat(x.hi)
   lo = BigFloat(x.lo)
   hi + lo
end

promote_rule{T<:SysFloat}(::Type{FloatFloat{FloatFloat{T}}}, ::Type{BigFloat}) = BigFloat
=#    



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
