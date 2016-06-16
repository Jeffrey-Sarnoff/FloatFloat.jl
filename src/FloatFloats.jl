module FloatFloats

import Base: hash, string, String,
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
    log, log1p, exp, expm1, 
    sin, cos, tan, csc, sec, cot, 
    asin, acos, atan, acsc, asec, acot,
    sinh, cosh, tanh, csch, sech, coth, 
    asinh, acosh, atanh, acsch, asech, acoth,
    gamma, lgamma, zeta

import Base.Math:@horner    


export FloatFloat, Float, FF, FF64, FF128, hi, lo,
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

if VERSION > v"0.5.0-dev"
    setprecision(BigFloat,384)
else
    set_bigfloat_precision(384)
end

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
