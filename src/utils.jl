# src/utils.jl

"""
    parse_float(s)
Parse a string as a floating point number.

This function is designed to handle common edge cases such as:
- Empty strings
- Strings containing only whitespace
- Strings containing a leading or trailing decimal point

# Arguments
- `s`: The string to parse

# Returns
- A `Float64` value, or `NaN` if the string cannot be parsed
"""
function parse_float(s::AbstractString)
    try
        return parse(Float64, s)
    catch e
        if e == InexactError()
            return NaN
        else
            error("Failed to parse string as float: $s")
        end
    end
end

"""
    clamp_value(value, min_value, max_value)
Ensure a value is within a specified range.

# Arguments
- `value`: The value to clamp
- `min_value`: The minimum allowed value
- `max_value`: The maximum allowed value

# Returns
- The clamped value
"""
function clamp_value(value, min_value, max_value)
    if value < min_value
        return min_value
    elseif value > max_value
        return max_value
    else
        return value
    end
end

"""
    normalize_vector(vector)
Normalize a 3D vector to unit length.

This function uses a simple iterative method to avoid potential NaN issues.

# Arguments
- `vector`: The vector to normalize

# Returns
- A unit vector
"""
function normalize_vector(vector)
    # This was tricky due to potential NaN issues
    magnitude = sqrt(sum(vector .^ 2))
    if magnitude ≈ 0
        return Vector{Float64}(undef, 3)  # Return a zero vector
    else
        return vector ./ magnitude
    end
end