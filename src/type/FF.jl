immutable FF{T<:Real} <: Real
    hi::T
    lo::T
end

typealias FF32  FF{Float16}
typealias FF64  FF{Float32}
typealias FF128 FF{Float64}

