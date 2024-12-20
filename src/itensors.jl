using ITensors: ITensors

# ITensors interoperability extension

"""
    op(sites::Vector{<:Index}, p::PauliString)

Return an ITensor corresponding the Pauli string operator.
"""
function ITensors.op(sites::Vector{<:ITensors.Index}, p::PauliString)
    length(p) != length(sites) && "Lengths of Pauli string and Index vector differ."
    x = ITensors.OneITensor()
    for (s, i) in zip(string.(pauli_inttochar.(operators(p))), indices(p))
        x *= op(sites, s, i)
    end
    return x
end
