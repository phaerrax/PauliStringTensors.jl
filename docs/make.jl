using PauliStrings
using Documenter

DocMeta.setdocmeta!(PauliStrings, :DocTestSetup, :(using PauliStrings); recursive=true)

makedocs(;
    modules=[PauliStrings],
    authors="Davide Ferracin <davide.ferracin@protonmail.com> and contributors",
    sitename="PauliStrings.jl",
    format=Documenter.HTML(; edit_link="main", assets=String[]),
    pages=["Home" => "index.md"],
)
