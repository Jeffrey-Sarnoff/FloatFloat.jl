# ambiguity resolution
convert{T<:SysFloat}(::Type{Bool}, x::FloatFloat{T}) = (x.hi != zero(T))
convert{T<:SysFloat}(::Type{FloatFloat{T}}, x::Bool) = x ? one(FloatFloat{T}) : zero(FloatFloat{T})

convert{T<:SysFloat}(::Type{FloatFloat{T}}, x::Integer) =  
   convert(FloatFloat{T}, convert(BigFloat,convert(BigInt,x)))
convert{T<:SysFloat}(::Type{Integer}, x::FloatFloat{T}) =  
   x.lo==zero(T) ? convert(Int64,convert(BigFloat,x)) : throw(InexactError())

convert{I<:Integer}(::Type{FloatFloat},x::I) = convert(FloatFloat{Float64}, x)
convert{I<:Integer}(::Type{FloatFloat},x::Rational{I}) = convert(FloatFloat{Float64}, x)
convert{F<:AbstractFloat}(::Type{FloatFloat},x::F) = convert(FloatFloat{Float64}, x)
convert{R<:Real}(::Type{FloatFloat},x::R) = convert(FloatFloat{Float64}, x)


#=
convert{T<:SysFloat,I<:Integer}(::Type{FloatFloat{T}}, x::I) =
   convert(FloatFloat{T}, convert(BigFloat,convert(BigInt,x)))
convert{T<:SysFloat,I<:Integer}(::Type{I}, x::FloatFloat{T}) =
   convert(I, convert(BigInt,convert(BigFloat,x)))
convert{T1<:SysFloat, T2<:SysFloat}(::Type{FloatFloat{T1}}, x::FloatFloat{T2}) =
   FloatFloat{T1}((T1)(x.hi)) + FloatFloat{T1}((T1)(x.lo))
convert{T1<:SysFloat}(::Type{FloatFloat{T1}}, x::FloatFloat{SysFloat}) =
   FloatFloat{T1}((T1)(x.hi)) + FloatFloat{T1}((T1)(x.lo))
=#
   
#
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

#FloatFloat{Float64}(x::BigFloat) = convert(FloatFloat{Float64}, x)
#FloatFloat{Float32}(x::BigFloat) = convert(FloatFloat{Float32}, x)
BigFloat{T<:SysFloat}(x::FloatFloat{T}) = convert(BigFloat, x)
#FloatFloat{Float64}(x::String) = convert(FloatFloat{Float64}, parse(BigFloat,x))
#FloatFloat{Float32}(x::String) = convert(FloatFloat{Float32}, parse(BigFloat,x))
String{T<:SysFloat}(x::FloatFloat{T}) = String(convert(BigFloat,x))

function convert{T1<:Integer, T2<:SysFloat}(::Type{Rational{T1}}, x::FloatFloat{T2})
   br = convert(Rational{BigInt},x.hi) + convert(Rational{BigInt},x.lo)
   convert(Rational{T1}, br)
end

function convert{T<:SysFloat}(::Type{FloatFloat{T}}, x::Real)
   bf = convert(BigFloat, x)
   convert(FloatFloat{T}, bf)
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
