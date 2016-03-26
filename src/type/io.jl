function string{T}(x::FloatFloat{T})
    string("FF(",x.hi,", ",x.lo,")")
end

function stringcompact{T}(x::FloatFloat{T})
    string("FF(",Float32(x.hi),", ",Float32(x.lo),")")
end

function show{T}(io::IO, x::FloatFloat{T})
    print(io, string(x))
end

function showcompact{T}(io::IO, x::FloatFloat{T})
    print(io, stringcompact(x))
end

function showall{T}(io::IO, x::FloatFloat{T})
    print(io, string(x))
end
