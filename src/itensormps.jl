using ITensorMPS

import ITensors: Index
import ITensors.SiteTypes: _sitetypes, commontags, tags

# ITensorMPS interoperability extension

ITensorMPS.MPO(::SiteType, sites::Vector{<:Index}, p::PauliString) = nothing

"""
    MPO(sites::Vector{<:Index}, p::PauliString)

Return an MPO corresponding to the Pauli string `p` on the site indices `sites`.
"""
function ITensorMPS.MPO(sites::Vector{<:Index}, p::PauliString)
    length(p) != length(sites) && "Lengths of Pauli string and Index vector differ."
    commontags_s = commontags(sites...)
    common_stypes = _sitetypes(commontags_s)
    for st in common_stypes
        res = MPO(st, sites, p)
        !isnothing(res) && return res
    end

    return throw(
        ArgumentError(
            "Overload of \"MPO\" function not found for gate name \"$name\" and Index " *
            "tags: $(tags.(sites)).",
        ),
    )
end

function ITensorMPS.MPO(::SiteType"Qubit", sites::Vector{<:Index}, p::PauliString)
    opnames = string.(pauli_inttochar.(p.string))
    opnames = replace.(opnames, "I" => "Id")
    return MPO(ComplexF64, sites, opnames)
end
