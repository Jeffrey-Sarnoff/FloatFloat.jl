function string{T<:SysFloat}(x::FloatFloat{T})
    string("FF(",x.hi,", ",x.lo,")")
end

function stringcompact{T<:SysFloat}(x::FloatFloat{T})
    string("FF(",Float32(x.hi),", ",Float32(x.lo),")")
end

function show{T<:SysFloat}(io::IO, x::FloatFloat{T})
    print(io, string(x))
end

function showcompact{T<:SysFloat}(io::IO, x::FloatFloat{T})
    print(io, stringcompact(x))
end

function showall{T<:SysFloat}(io::IO, x::FloatFloat{T})
    print(io, string(x))
end
