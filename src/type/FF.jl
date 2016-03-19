immutable FF{T<:Real} <: Real
    hi::T
    lo::T
end

typealias FF32  FF{Float16}
typealias FF64  FF{Float32}
typealias FF128 FF{Float64}

const hash_fflo = (UInt === UInt64) ? 0x086540d7a5325bc3 : 0x5acda43c
const hash_0_fflo = hash(zero(UInt), hash_fflo)
hash{T<:Real}(z::FF{T}, h::UInt) = hash(z.hi, h $ has(z.lo, hash_fflow) $ hash_0_fflo)
