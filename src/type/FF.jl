immutable FF{T<:Real} <: Real
    hi::T
    lo::T
end

typealias FF32  FF{Float16}
typealias FF64  FF{Float32}
typealias FF128 FF{Float64}

const hash_ff_lo = (UInt === UInt64) ? 0x086540d7a5325bc3 : 0x5acda43c
const hash_0_ff_lo = hash(zero(UInt), hash_ff_lo)
hash{T<:Real}(z::FF{T}, h::UInt) = 
    hash(z.hi, (h $ hash(z.lo, hash_ff_lo) $ hash_0_ff_lo))
