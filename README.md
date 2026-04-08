<h1 align="center">A052199.jl</h1>

[![Build Status](https://github.com/jakewilliami/A052199.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/jakewilliami/A052199.jl/actions/workflows/CI.yml?query=branch%3Amaster)

Julia implementation for calculating terms in the sequence [A052199](https://oeis.org/A052199).

Credit to Don S. McDonald [[1](https://rgdsm.wordpress.com/), [2](https://x.com/McDONewt), [3](https://www.facebook.com/MCDONewt/)], who was one of the first people to formalise this sequence, and who told me about it in 2023 after starting an online conversation in 2021.

## Quick Start

```julia-repl
julia> import Pkg; Pkg.add(url="https://github.com/jakewilliami/A052199.jl")

julia> using A052199

julia> a052199(10)  # 10th term in A052199
160225

julia> l052199()  # First 10 terms in A052199
10-element Vector{Int64}:
      1
      5
     65
    325
   1105
   5525
  27625
  71825
 138125
 160225
```
