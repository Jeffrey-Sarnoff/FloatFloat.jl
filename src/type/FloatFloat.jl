immutable FloatFloat{T<:Real} <: Real
    hi::T    # high order part, precision of type T 
    lo::T    # low  order part, extended precision
    
    FloatFloat{T}(hi::T, lo::T) = new(hi,lo)
end

# matching to the internal constructor
FloatFloat{T<:Real}(hi::T, lo::T) = FloatFloat{T}(hi,lo)
# augmenting external construction
FloatFloat{T<:Real}(hi::T) = FloatFloat{T}(hi,zero(T))
# handle other reasonable inputs
function FloatFloat{T1<:Real, T2<:Real}(hi::T1, lo::T2)
    a,b = promote(hi,lo)
    FloatFloat{typeof(a)}(a,b)
end    


# use convert to ensure magnitude(hi) >= magnitude(lo)
convert{T<:Real}(::Type{FloatFloat{T}}, a::T, b::T) = 
   ifelse(abs(a)>abs(b), FloatFloat(a,b), FloatFloat(b,a))
# augment external conversion (allows e.g. convert(FloatFloat, Float32(a), Float32(b))
convert{T<:Real}(::Type{FloatFloat}, a::T, b::T) = convert(FloatFloat{T}, a, b)
# allows e.g. convert(FloatFloat, Int32(a), Float64(b))
convert{T1<:Real, T2<:Real}(::Type{FloatFloat}, a::T1, b::T2) = convert(FloatFloat, promote(a,b)...)



