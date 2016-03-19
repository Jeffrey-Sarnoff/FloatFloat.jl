module FloatFloat

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule,
    isequal, isless, 
    (==),(!=),(<),(<=),(>=),(>),
    (+),(-),(*),(/),(\),(%),(^)

export FF32, FF64, FF128

using ErrorfreeArithmetic
using AccurateArithmetic

include("type/FF.jl")
include("type/io.jl")

end # module
