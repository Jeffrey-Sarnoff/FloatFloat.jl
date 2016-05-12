
function log(a::FloatFloat{Float64})
    logA = log(a.hi) + (a.lo / a)
    elogA = exp(logA)
    logA += (a - elogA)/elogA.hi
    elogA = exp(logA)
    logA + (a - elogA)/elogA
end
