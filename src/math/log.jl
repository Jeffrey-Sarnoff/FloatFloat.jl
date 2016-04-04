
const FF64_log2 = FloatFloat{Float64}(0.6931471805588453, 2.3190468138462996e-17)

function log(x::FloatFloat{Float64})

    y = x / FF64_log2
    iy = trunc(Int64,y.hi)
    y = (y - Float64(iy)) * FF64_log2
    y = divby2(y)
    
    ysq = y*y
    sum1 = y * ((((ysq + 3960.0)*ysq + 2162160.0)*ysq + 302702400.0)*ysq +  8821612800.0)
    sum2 = (((90.*ysq + 110880.)*ysq + 30270240.0)*ysq + 2075673600.0)*ysq +17643225600.0
    
    temp = sum1 / (sum2 - sum1)
    y = temp * (temp + 1.0)
    y = divby2(divby2(y))
    y = y + 1.0
    y = divbypow2(y, iy)
    y
end
