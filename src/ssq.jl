using Primes

# This function counts the number of distinct ways that an integer a can be written as the
# sum of two squares, x² + y².
#
# That is (given our previous notation), this function computes r(a).
#
# Previous implementation:
#   <https://github.com/jakewilliami/A052199.jl/blob/v1.0.0/src/A052199.jl#L22-L28>
function _number_of_two_square_sums(a::Int)
    # Any integer can be represented as prime factors.  We need this number's factorisation
    #
    # <https://en.wikipedia.org/wiki/Fundamental_theorem_of_arithmetic>
    factors = factor(a)

    # Check primes ≡ 3 (mod 4)
    # ========================
    #
    # The sum of two squares theorem states that
    #     An integer greater than one can be written as a sum of two squares ⟺ if its
    #     prime decomposition contains no factor pᵏ, where prime p ≡ 3 (mod 4) and k is
    #     odd.
    #
    # Therefore, step 1 is to elimitate the case that _no_ squares exist.
    #
    #   <https://en.wikipedia.org/wiki/Sum_of_two_squares_theorem>
    for (p, k) in factors
        if mod(p, 4) == 3 && isodd(k)
            return 0
        end
    end

    # Compute product over primes ≡ 1 (mod 4)
    # =======================================
    #
    # There are eight ways of writing equivalent solutions of sums of squares.  For
    # example, x² + y² = (−x)² + (−y)² = (−y)² + x².
    #
    # Therefore, if we can count the set of all integer pairs whose sum of squares
    # gets our number:
    #     |{(x, y) ∈ ℤ²: x² + y² = n}|
    #
    # Then, if we can find the total number of representations r(n), we can simply
    # divide it by eight.
    #
    # By the fundamental theorem of arithmetic, any number n can be written as the product
    # of primes
    #     n = p₁^(α_p₁) ⋅ p₂^(α_p₂) ⋅ … = Π p^(α_p)
    #
    # But Jacobi's two-square theorem states that the number of ways of writing n as a
    # sum of two squares is:
    #     r(n) = 4 Π (α_p + 1)      for all p ≡ 1 (mod 4)
    #
    # This behaves like a restricted divisor count.  We have already filtered out odd
    # exponents from our previous step, so
    #
    #
    # To find the number of ways a positive integer n > 1 can be expressed as a sum of
    # 2 squares, ignoring order and signs, factor it as
    #     n = 2^a₀ + p₁^(2a₁) ⋯ pᵣ^(2aᵣ) q₁^(b₁) ⋯ q_s^(b_s)
    #
    # Where pᵢ are primes of the form 4k + 3 (i.e., pᵢ ≡ 3 (mod 4))
    # And qᵢ are primes of the form 4k + 1 (i.e, qᵢ ≡ 1 (mod 4))
    #
    # Because we know that n does not have such a represesentation with integer aᵢ (because
    # one or more of the powers of pᵢ is odd, if we got here in the function), then we
    # define:
    #     B ≡ (b₁ + 1) (b₂ + 1) ⋯ (bᵣ + 1)
    #
    # Remember, each b is the exponent of all primes qᵢ ≡ 1 (mod 4).
    #
    # Then, the number of representations of n as the sum of two squares, ignoring order
    # and signs, for n > 1, is then given by
    #     r(n) = 4B
    #
    # Restricting to distinct positive solutions with x > y > 0, each solution is counted
    # 8 times in r(n), so the number of such solutions is:
    #     r(n) = 4B / 8
    #          = B / 2
    #
    # This division will remove duplicates.
    #
    #   <https://mathworld.wolfram.com/SumofSquaresFunction.html>
    #
    # Note: Jacobi's theorem similarly states that:
    #     r(n) = 4(d₁(n) - d₃(n))
    #
    # Where:
    #   d₁(n) is number of divisors of a congruent to 1 (mod 4)
    #   d₃(n) is number of divisors of a congruent to 3 (mod 4)
    #
    #   <https://en.wikipedia.org/wiki/Sum_of_two_squares_theorem#Jacobi's_two-square_theorem>
    r = prod(factors, init = 1) do (p, k)
        isone(mod(p, 4)) ? k + 1 : 1
    end

    return r ÷ 2  # Equivalent to r(n) ÷ 8
end
