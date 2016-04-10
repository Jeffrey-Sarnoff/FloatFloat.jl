module FloatFloats

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule,
    zero, one, ldexp, frexp,
    isnan, isinf, isfinite, issubnormal,
    isequal, isless,
    signbit, sign, copysign, flipsign, abs,
    (==),(!=),(<),(<=),(>=),(>),
    (+),(-),(*),(/),(\),(%),(^),
    inv, sqrt, hypot,
    log

import Genera: StdFloat, SysFloat

export FloatFloat, FF, FF32, FF64, FF128,
    iszero, isnonzero, ispos, isneg, isnonneg,
    hash,
    NaNFF, InfFF,
    mulby2, divby2, mulpow2, divpow2, sqr,
    sqrt, log

using ErrorfreeArithmetic

# using AccurateArithmetic

include("type/FloatFloat.jl")
include("type/FF.jl")
include("type/primitive.jl")
include("type/predicates.jl")
include("type/convert.jl")
include("type/io.jl")

include("arith/addsub.jl")
include("arith/mul.jl")
include("arith/div.jl")
include("arith/sqrt.jl")

end # module
