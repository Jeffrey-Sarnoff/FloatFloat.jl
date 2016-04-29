function isless{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T})
    (a.hi < b.hi) || (a.hi==b.hi && a.lo<b.lo)
end
function isless{T<:StdFloat}(a::FloatFloat{T}, b::Float64)
    (a.hi < b) || (a.hi==b && a.lo<zero(Float64))
end
function isless{T<:StdFloat}(a::Float64, b::FloatFloat{T})
    (a < b.hi) || (a==b.hi && b.lo<zero(Float64))
end
function isless{T<:StdFloat}(a::Float32, b::FloatFloat{T})
    (a < b.hi) || (a==b.hi && b.lo<zero(Float32))
end
function isless{T<:StdFloat}(a::FloatFloat{T}, b::Float32)
    (a.hi < b) || (a.hi==b && a.lo<zero(Float32))
end

function isequal{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T})
    (a.hi == b.hi) && (a.lo == b.lo)
end
function isequal{T<:StdFloat}(a::FloatFloat{T}, b::Float64)
    (a.hi == b) && (a.lo == zero(Float64))
end
function isequal{T<:StdFloat}(a::Float64, b::FloatFloat{T})
    (a == b.hi) && (b.lo == zero(Float64))
end
function isequal{T<:StdFloat}(a::FloatFloat{T}, b::Float32)
    (a.hi == b) && (a.lo == zero(Float32))
end
function isequal{T<:StdFloat}(a::Float32, b::FloatFloat{T})
    (a == b.hi) && (b.lo == zero(Float32))
end

@inline (==){T<:StdFloat}(a::FloatFloat{T},b::FloatFloat{T}) = (a.hi == b.hi) && (a.lo == b.lo)
@inline (< ){T<:StdFloat}(a::FloatFloat{T},b::FloatFloat{T}) = (a.hi < b.hi) || (a.hi==b.hi && a.lo<b.lo)
@inline (<=){T<:StdFloat}(a::FloatFloat{T},b::FloatFloat{T}) = (a.hi < b.hi) || (a.hi==b.hi && a.lo<=b.lo)
@inline (> ){T<:StdFloat}(a::FloatFloat{T},b::FloatFloat{T}) = (a.hi > b.hi) || (a.hi==b.hi && a.lo>b.lo)
@inline (>=){T<:StdFloat}(a::FloatFloat{T},b::FloatFloat{T}) = (a.hi > b.hi) || (a.hi==b.hi && a.lo>=b.lo)

min{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = (a<b) ? a : b
max{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = (b<a) ? a : b
minmax{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = (a<b) ? (a,b) : (b,a)
maxmin{T<:StdFloat}(a::FloatFloat{T}, b::FloatFloat{T}) = (b<a) ? (a,b) : (b,a)

