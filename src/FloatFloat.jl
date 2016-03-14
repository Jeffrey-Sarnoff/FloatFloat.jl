module FloatFloat

import Base: hash, string, 
    show, showcompact, showall,
    convert, promote_rule,
    isequal, isless, 
    (==),(!=),(<),(<=),(>=),(>),
    (+),(-),(*),(/),(\),(%),(^)

export FF32, FF64, FF128

using ErrorfreeArithmetic

include("type/FF.jl")

end # module
