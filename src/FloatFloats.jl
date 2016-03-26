module FloatFloats

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule,
    ldexp, frexp,
    isnan, isinf, isfinite, issubnormal,
    isequal, isless,
    signbit, sign, copysign, flipsign, abs,
    (==),(!=),(<),(<=),(>=),(>),
    (+),(-),(*),(/),(\),(%),(^),
    sqrt, hypot

import JAS: StdFloat

export FloatFloat, FF, FF32, FF64, FF128,
    iszero, isnonzero, ispos, isneg, isnonneg,
    hash

using ErrorfreeArithmetic
using AccurateArithmetic

include("type/FloatFloat.jl")
include("type/FF.jl")
include("type/numparts.jl")
include("type/predicates.jl")
include("type/convert.jl")
include("type/io.jl")

include("arith/addsub.jl")
include("arith/mul.jl")
include("arith/div.jl")
include("arith/sqrt.jl")

end # module
