"""
Module: Forces

Définition des fonctions pour calculer les forces entre molécules.

# Types

## Molécule

Une molécule est représentée par un objet du type `Molecule` qui possède
des propriétés suivantes :

- `id::Int64` : identifiant unique de la molécule
- `position::Vector{Float64}` : coordonnées 3D de la molécule
- `velocity::Vector{Float64}` : vecteur de vitesse de la molécule

## Force

Une force est représentée par un objet du type `Force` qui possède
des propriétés suivantes :

- `id::Int64` : identifiant unique de la force
- `magnitude::Float64` : magnitude de la force
- `direction::Vector{Float64}` : direction de la force

## Molécule-Force

Une molécule-force est une paire molécule-force qui possède
des propriétés suivantes :

- `molécule::Molecule` : molécule associée
- `force::Force` : force associée

# Fonctions

## `calculate_force(molécule1, molécule2)`

Calcul la force entre deux molécules.

## `calculate_forces(molécules)`

Calcul les forces entre toutes les molécules d'une liste.

## `update_molécules(molécules, forces)`

Actualise les propriétés des molécules en fonction des forces calculées.
"""

module Forces

using ..Molecules
using ..Utils

"""
Calcul la force entre deux molécules.

# Arguments

- `molécule1::Molecule` : première molécule
- `molécule2::Molecule` : deuxième molécule

# Renvoie

- `force::Force` : force calculée
"""
function calculate_force(molécule1::Molecule, molécule2::Molecule)
    # Calcul de la distance entre les deux molécules
    distance = norm(molécule1.position - molécule2.position)

    # Calcul de la force de répulsion
    force_magnitude = 1 / (distance^2)
    force_direction = (molécule1.position - molécule2.position) / distance

    # Création de la force
    force = Force(id=1, magnitude=force_magnitude, direction=force_direction)

    return force
end

"""
Calcul les forces entre toutes les molécules d'une liste.

# Arguments

- `molécules::Vector{Molecule}` : liste de molécules

# Renvoie

- `forces::Vector{Force}` : liste de forces calculées
"""
function calculate_forces(molécules::Vector{Molecule})
    forces = Vector{Force}()

    # Boucle sur toutes les paires de molécules
    for i in 1:length(molécules)
        for j in (i+1):length(molécules)
            # Calcul de la force entre les deux molécules
            force = calculate_force(molécules[i], molécules[j])

            # Ajout de la force à la liste
            push!(forces, force)
        end
    end

    return forces
end

"""
Actualise les propriétés des molécules en fonction des forces calculées.

# Arguments

- `molécules::Vector{Molecule}` : liste de molécules
- `forces::Vector{Force}` : liste de forces calculées
"""
function update_molécules(molécules::Vector{Molecule}, forces::Vector{Force})
    # Boucle sur toutes les molécules
    for i in 1:length(molécules)
        # Calcul de la force totale appliquée à la molécule
        force_total = sum(force.direction * force.magnitude for force in forces if force.molécule == molécules[i])

        # Actualisation de la position et de la vitesse de la molécule
        molécules[i].position += force_total
        molécules[i].velocity += force_total
    end

    return molécules
end

end  # module Forces