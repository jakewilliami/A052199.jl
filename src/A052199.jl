module A052199

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
    a::T    # The current best number by ways you can write as sum of two squares (TODO: should I use aₙ?)
    r::Int  # The number of ways you can write `n` as the sum of two squares (r for representations)
end

function _number_of_two_square_sums(a::Int)
    # First, see if we have memoised it already

    # If it is not memoised, we will have to calculate it
    return sum(1:isqrt(a), init = 0) do i
        sum(1:(i - 1), init = 0) do j
            return i^2 + j^2 == a
        end
    end
end

# Base case: 1 is the first positive number and can be written as the sum of two squares
# in 0 different ways
Base.iterate(::_Iterator) = 1, _State(1, 0)

# Nᵗʰ case: keep incrementing n until we find one with a larger m
function Base.iterate(iter::_Iterator, state::_State)
    # NOTE: this is slower than l052199
    r, a = state.r, state.a

    while r <= state.r
        a += 1
        r = _number_of_two_square_sums(a)
    end

    return a, _State(a, r)
end

function a052199(n::Int)
    # Find the nᵗʰ A05199 number

    # `zip` forces `a052199` iterator to short-circut after m iterations
    # Can't use `zip` until v1.13: github.com/JuliaLang/julia/issues/58922
    # return last(last(zip(1:m, a052199())))

    i = 1
    for a in a052199()
        n == i && return a
        i += 1
    end

    error("unreachable")
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
