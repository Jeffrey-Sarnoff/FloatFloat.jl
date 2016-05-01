#=
    decomposing a function parameter's value, argument reduction
    
    refs:
         Efficient implementation of elementary functions in the medium-precision range (arXiv:1410.7176v2)
         and ARITH 22 presentation (http://fredrikj.net/math/arith2015elementary.pdf) 
         by Fredrik Johansson
        
         
    for x in [0,1) and r from {4,5,6,7,8}
        q  = 2^r == 1<<r == trunc(Int,ldexp(1.0,r))
        i  = floor(Int, x*q) == floor(Int, x * 2^r) == floor(Int, x * 1<<r) == floor(Int, ldexp(x,r))
        t  = i/q
        w  = x - t == x - i/q
        w1 = (x*q - i) / (q +   i)
        w2 = (x*q - i) / (q + x*i)
         
    exp(x)   = exp(t) * exp(w)
    log(1+x) = log(1+t) + log(1+w1)
    sin(x)   = sin(t)*cos(w) + sin(w)*cos(t)
    cos(x)   = cos(t)*cos(w) - sin(w)*sin(t)
    atan(x)  = atan(t) + atan(w2)
    
=#
