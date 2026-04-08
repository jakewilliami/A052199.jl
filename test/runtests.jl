using A052199
using DelimitedFiles
using Downloads
using Test

# Download the first numbers in the sequence from OEIS
function _top_n_from_oeis()
    f = Downloads.download("https://oeis.org/A052199/b052199.txt")
    data = readdlm(f, ' ', BigInt; comments = true)
    return data[axes(data, 1), 2]
end

const OEIS_RESULTS = _top_n_from_oeis()

@testset "A052199.jl" begin
    @test a052199(1) == 1
    @test a052199(2) == 5
    @test a052199(3) == 65
    @test a052199(4) == 325
    @test a052199(5) == 1105
    @test a052199(10) == 160225
    @test l052199(10) == OEIS_RESULTS[1:10]
end
