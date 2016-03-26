FF128{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float64(hi),Float64(lo))
FF64{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float32(hi),Float32(lo))
FF32{T1<:Real, T2<:Real}(hi::T1, lo::T2) = FF(Float16(hi),Float16(lo))
FF128{T<:Real}(hi::T) = FloatFloat{Float64}(Float64(hi))
FF64{T<:Real}(hi::T) = FloatFloat{Float32}(Float32(hi))
FF32{T<:Real}(hi::T) = FloatFloat{Float16}(Float16(hi))

const hash_ff_lo = (UInt === UInt64) ? 0x086540d7a5325bc3 : 0x5acda43c
const hash_0_ff_lo = hash(zero(UInt), hash_ff_lo)
hash{T<:Real}(z::FF{T}, h::UInt) = 
    hash(z.hi, (h $ hash(z.lo, hash_ff_lo) $ hash_0_ff_lo))
