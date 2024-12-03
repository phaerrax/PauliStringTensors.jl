module LindbladVectorizedTensorsExt

using PauliStringTensors

using LindbladVectorizedTensors
using ITensorMPS

using ITensors: Index
using ITensors.SiteTypes: _sitetypes, commontags, tags

# LindbladVectorizedTensors interoperability extension

ITensorMPS.MPS(::SiteType, sites::Vector{<:Index}, p::PauliString) = nothing

"""
    MPS(sites::Vector{<:Index}, p::PauliString)

Return an MPS corresponding to the Pauli string `p` on the site indices `sites`.
"""
function ITensorMPS.MPS(sites::Vector{<:Index}, p::PauliString)
    length(p) != length(sites) && "Lengths of Pauli string and Index vector differ."
    commontags_s = commontags(sites...)
    common_stypes = _sitetypes(commontags_s)
    for st in common_stypes
        res = MPS(st, sites, p)
        !isnothing(res) && return res
    end

    return throw(
        ArgumentError(
            "Overload of \"MPS\" function not found for gate name \"$name\" and Index " *
            "tags: $(tags.(sites)).",
        ),
    )
end

function ITensorMPS.MPS(::SiteType"vQubit", sites::Vector{<:Index}, p::PauliString)
    statenames = string.(PauliStringTensors.pauli_inttochar.(p.string))
    statenames = replace.(statenames, "I" => "Id")
    vstatenames = ["v$sn" for sn in statenames]
    return MPS(sites, vstatenames)
end

end
