# src/integrator.jl

"""
Intégrateur pour la simulation de dynamique moléculaire.
"""
module Integrator

using ..utils: calculate_distance, calculate_force
using ..molecules: Molecule
using ..forces: Force

"""
Type de l'intégrateur.
"""
abstract type Integrator end

"""
Type de l'intégrateur de champ.
"""
abstract type FieldIntegrator <: Integrator end

"""
Type de l'intégrateur de Verlet.
"""
struct VerletIntegrator <: FieldIntegrator
    time_step::Float64
end

"""
Initialise l'intégrateur de Verlet.
"""
function VerletIntegrator(time_step::Float64)
    return VerletIntegrator(time_step)
end

"""
Intègre les positions et vitesses des molécules pour une étape de temps.
"""
function integrate!(integrator::VerletIntegrator, molecules::Vector{Molecule}, time_step::Float64)
    for molecule in molecules
        # Calcul de la position et de la vitesse actuelles
        position = molecule.position
        velocity = molecule.velocity

        # Calcul de la position et de la vitesse futures
        distance = calculate_distance(molecule, molecules)
        force = calculate_force(molecule, molecules)
        new_position = position + velocity * time_step + 0.5 * force * time_step^2
        new_velocity = velocity + 0.5 * force * time_step

        # Mise à jour de la position et de la vitesse
        molecule.position = new_position
        molecule.velocity = new_velocity
    end
end

"""
Intègre les positions et vitesses des molécules pour une étape de temps.
"""
function integrate!(integrator::VerletIntegrator, molecules::Vector{Molecule}, time_step::Float64, force::Force)
    for molecule in molecules
        # Calcul de la position et de la vitesse actuelles
        position = molecule.position
        velocity = molecule.velocity

        # Calcul de la position et de la vitesse futures
        distance = calculate_distance(molecule, molecules)
        new_position = position + velocity * time_step + 0.5 * force * time_step^2
        new_velocity = velocity + 0.5 * force * time_step

        # Mise à jour de la position et de la vitesse
        molecule.position = new_position
        molecule.velocity = new_velocity
    end
end

"""
Intègre les positions et vitesses des molécules pour une étape de temps.
"""
function integrate!(integrator::VerletIntegrator, molecules::Vector{Molecule}, time_step::Float64, force::Force, field::Vector{Float64})
    for molecule in molecules
        # Calcul de la position et de la vitesse actuelles
        position = molecule.position
        velocity = molecule.velocity

        # Calcul de la position et de la vitesse futures en tenant compte du champ
        distance = calculate_distance(molecule, molecules)
        field_force = force * field[molecule.index]
        new_position = position + velocity * time_step + 0.5 * field_force * time_step^2
        new_velocity = velocity + 0.5 * field_force * time_step

        # Mise à jour de la position et de la vitesse
        molecule.position = new_position
        molecule.velocity = new_velocity
    end
end

end  # module Integrator