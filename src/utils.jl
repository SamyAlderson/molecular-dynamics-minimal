# src/utils.jl

"""
Module contenant des utilitaires pour la simulation de dynamique moléculaire.
"""

module Utils

# Importation des modules nécessaires
using LinearAlgebra
using Statistics

"""
Fonction pour calculer la distance entre deux points.
"""
function distance(p1::Vector{Float64}, p2::Vector{Float64})
    """
    Retourne la distance entre deux points.

    Arguments:
    - `p1`: Premier point
    - `p2`: Deuxième point

    Retour:
    - `Float64`: Distance entre les deux points
    """
    return sqrt((p1[1] - p2[1])^2 + (p1[2] - p2[2])^2)
end

"""
Fonction pour calculer la somme des carrés des composantes d'une liste de vecteurs.
"""
function sum_of_squares(vectors::Vector{Vector{Float64}})
    """
    Retourne la somme des carrés des composantes d'une liste de vecteurs.

    Arguments:
    - `vectors`: Liste de vecteurs

    Retour:
    - `Float64`: Somme des carrés des composantes
    """
    return sum(abs2, [vec for vec in vectors])
end

"""
Fonction pour calculer la moyenne des composantes d'une liste de vecteurs.
"""
function mean_of_components(vectors::Vector{Vector{Float64}})
    """
    Retourne la moyenne des composantes d'une liste de vecteurs.

    Arguments:
    - `vectors`: Liste de vecteurs

    Retour:
    - `Vector{Float64}`: Moyenne des composantes
    """
    return [mean([vec[i] for vec in vectors]) for i in 1:length(vectors[1])]
end

end  # Module Utils
```

```julia
# tests/test_utils.jl

"""
Tests pour le module `Utils`.
"""

using Test
using Utils

@testset "Utils" begin
    # Tests pour la fonction `distance`
    @test distance([0.0, 0.0], [3.0, 4.0]) ≈ 5.0 atol=1e-6
    @test distance([1.0, 2.0], [3.0, 4.0]) ≈ √2 atol=1e-6

    # Tests pour la fonction `sum_of_squares`
    @test sum_of_squares([[1.0, 2.0], [3.0, 4.0]]) ≈ 29 atol=1e-6
    @test sum_of_squares([[5.0, 6.0], [7.0, 8.0]]) ≈ 205 atol=1e-6

    # Tests pour la fonction `mean_of_components`
    @test mean_of_components([[1.0, 2.0], [3.0, 4.0]]) ≈ [2.0, 3.0] atol=1e-6
    @test mean_of_components([[5.0, 6.0], [7.0, 8.0]]) ≈ [6.0, 7.0] atol=1e-6
end