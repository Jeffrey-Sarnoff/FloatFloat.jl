isnan{T<:AbstractFloat}(a::FF{T})       = isnan(a.hi)
isinf{T<:AbstractFloat}(a::FF{T})       = isinf(a.hi)
isfinite{T<:AbstractFloat}(a::FF{T})    = isfinite(a.hi)
issubnormal{T<:AbstractFloat}(a::FF{T}) = issubnormal(a.hi)

iszero{T<:AbstractFloat}(a::FF{T})   = (a.hi == zero(T))
ispos{T<:AbstractFloat}(a::FF{T})    = (a.hi >= zero(T))
isneg{T<:AbstractFloat}(a::FF{T})    = signbit(a.hi)
isnonneg{T<:AbstractFloat}(a::FF{T}) = !signbit(a.hi)
