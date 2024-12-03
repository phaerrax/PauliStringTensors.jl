using PauliStringTensors
using Test

include("pauli_string_constructors.jl")

@testset "Consistency of Pauli string constructors" begin
    @test pauli_string_constructors()
end
