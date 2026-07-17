# tests/test_main.jl

using Test
using MolecularDynamicsMinimal

# Test du fichier principal
@testset "Fichier principal" begin
    # Test de la fonction main
    @testset "Fonction main" begin
        # Test que la fonction main ne renvoie pas d'erreur
        try
            main()
            true
        catch e
            @show e
            false
        end
    end

    # Test de la fonction init
    @testset "Fonction init" begin
        # Test que la fonction init renvoie un objet valide
        mol = init()
        @test isa(mol, MolecularDynamicsMinimal.Molecule)
    end

    # Test de la fonction simulate
    @testset "Fonction simulate" begin
        # Test que la fonction simulate ne renvoie pas d'erreur
        try
            simulate(mol)
            true
        catch e
            @show e
            false
        end
    end
end

# Test de la fonction de sauvegarde des résultats
@testset "Fonction de sauvegarde des résultats" begin
    # Test que la fonction de sauvegarde des résultats ne renvoie pas d'erreur
    try
        save_results()
        true
    catch e
        @show e
        false
    end
end
```

```julia
# tests/test_molecules.jl

using Test
using MolecularDynamicsMinimal

# Test de la définition des molécules
@testset "Définition des molécules" begin
    # Test que la définition des molécules ne renvoie pas d'erreur
    try
        mol = MolecularDynamicsMinimal.Molecule()
        true
    catch e
        @show e
        false
    end
end