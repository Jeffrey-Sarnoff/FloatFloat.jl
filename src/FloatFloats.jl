module FloatFloats

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule,
    zero, one, ldexp, frexp, eps,
    isnan, isinf, isfinite, issubnormal,
    isequal, isless, min, max, minmax,
    signbit, sign, copysign, flipsign, abs,
    (==),(!=),(<),(<=),(>=),(>),
    (+),(-),(*),(/),(\),(%),(^),
    inv, sqrt, hypot,
    log


export FloatFloat, #FF, FF64, FF128,
    iszero, isnonzero, ispos, isneg, isnonneg,
    hash, maxmin,
    ulp, NaNFF, InfFF,
    mulby2, divby2, mulpow2, divpow2, sqr,
    sqrt, log

using Polynomials
using Genera
using ErrorfreeArithmetic
using FloatSafeInts

# using AccurateArithmetic

include("type/FloatFloat.jl")
include("type/convert.jl")
#include("type/FF.jl")
include("type/primitive.jl")
include("type/predicates.jl")
include("type/compare.jl")
include("type/io.jl")

include("arith/addsub.jl")
include("arith/mul.jl")
include("arith/div.jl")
include("arith/sqrt.jl")

include("math/exp.jl")

end # module
