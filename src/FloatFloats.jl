module FloatFloats

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule, eltype,
    zero, one, ldexp, frexp, eps, modf,
    isnan, isinf, isfinite, issubnormal,
    isequal, isless, min, max, minmax,
    signbit, sign, copysign, flipsign, abs,
    (==),(!=),(<),(<=),(>=),(>),
    trunc,
    (+),(-),(*),(/),(\),(%),(^),
    inv, sqrt, hypot,
    log, exp,
    sin, cos, tan,
    String

import Base.Math:@horner    


export FloatFloat, FF, FF64, FF128, hi, lo,
    iszero, isnonzero, ispos, isneg, isnonneg,
    hash, maxmin, fmod,
    ulp, NaNFF, InfFF,
    mulby2, divby2, mulpow2, divpow2, sqr,
    @BigFloat, @BigInt


using Genera
using ErrorfreeArithmetic
using FloatSafeInts
#using FastPolynomials

macro BigFloat(x)
    parse(BigFloat, string(eval(:($x))))
end
macro BigInt(x)
    parse(BigInt, string(eval(:($x))))
end

setprecision(BigFloat,384)

include("type/Float.jl")

include("type/FloatFloat.jl")
include("type/convert.jl")

include("type/FF.jl")

include("type/primitive.jl")
include("type/predicates.jl")
include("type/compare.jl")
include("type/io.jl")

include("arith/addsub.jl")
include("arith/mul.jl")
include("arith/div.jl")
include("arith/sqrt.jl")

include("math/exp.jl")
include("math/log.jl")
include("math/trig.jl")

end # module
