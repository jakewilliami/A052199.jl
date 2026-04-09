module A052199

include("ssq.jl")

export a052199, l052199

### Iteration Interface ###

# Internal iterator struct for iteration interface
struct _Iterator{T <: Integer} end
_Iterator() = _Iterator{Int}()
Base.IteratorSize(::_Iterator{T}) where {T} = Base.IsInfinite()
Base.eltype(::_Iterator{T}) where {T} = T

# Constructor function so that the user can type `for i in a052199()`
a052199(T::Type{<:Integer} = Int) = _Iterator{T}()

# Internal state struct for iteration interface
struct _State{T <: Integer}
    a::T    # The current best number, rated by ways you can write as sum of two squares
    r::Int  # The number of ways you can write a as the sum of two squares (r for representations)
end

# Base case: 1 is the first positive number and can be written as the sum of two squares
# in 0 different ways
Base.iterate(::_Iterator{T}) where {T} = one(T), _State(one(T), 0)

# Nᵗʰ case: keep incrementing n until we find one with a larger m
function Base.iterate(::_Iterator{T}, state::_State{T}) where {T}
    a = state.a + one(T)
    r = _number_of_two_square_sums(a)

    while r <= state.r
        a += one(T)
        r = _number_of_two_square_sums(a)
    end

    return a, _State(a, r)
end

function a052199(n::Int)
    # Find the nᵗʰ A05199 number

    # `zip` forces `a052199` iterator to short-circut after m iterations
    # Can't use `zip` until v1.13: github.com/JuliaLang/julia/issues/58922
    # return last(last(zip(1:m, a052199())))
    #
    # Could use `nth` when it comes out.
    return first(Iterators.drop(a052199(), n - 1))
end

# Find the first n A052199 numbers
# Based on implementation by Derek Orr, Mar 15 2019
function l052199(n::Int)
    A = Int[]
    a, r_old = 1, -1

    while length(A) < n
        r = _number_of_two_square_sums(a)

        if r > r_old
            push!(A, a)
            r_old = r
        end

        a += 1
    end

    return A
end

end  # end module
