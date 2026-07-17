# src/molecules.jl

"""
    Molecule

Représente une molécule.

# Fields
- `name`: Nom de la molécule
- `atoms`: Liste d'atomes qui composent la molécule
- `positions`: Positions des atomes dans l'espace
- `velocities`: Vélocités des atomes
"""
mutable struct Molecule
    name::String
    atoms::Vector{Atom}
    positions::Matrix{Float64}
    velocities::Matrix{Float64}
end

"""
    Atom

Représente un atome.

# Fields
- `symbol`: Symbole de l'atome (par exemple "H" pour hydrogène)
- `mass`: Masse de l'atome
"""
mutable struct Atom
    symbol::String
    mass::Float64
end

"""
    create_molecule

Crée une nouvelle molécule à partir des paramètres donnés.

# Arguments
- `name`: Nom de la molécule
- `atoms`: Liste d'atomes qui composent la molécule
- `positions`: Positions des atomes dans l'espace
- `velocities`: Vélocités des atomes

# Returns
Une nouvelle molécule
"""
function create_molecule(name, atoms, positions, velocities)
    if length(atoms) ≠ size(positions, 2)
        error("Nombre d'atomes et de positions incohérents")
    end
    if length(atoms) ≠ size(velocities, 2)
        error("Nombre d'atomes et de vitesses incohérents")
    end
    Molecule(name, atoms, positions, velocities)
end

"""
    get_atom_mass

Renvoie la masse d'un atome.

# Arguments
- `atom`: Atome

# Returns
La masse de l'atome
"""
function get_atom_mass(atom::Atom)
    atom.mass
end

"""
    get_molecule_position

Renvoie la position d'un atome dans la molécule.

# Arguments
- `molecule`: Molécule
- `atom_index`: Index de l'atome

# Returns
La position de l'atome
"""
function get_molecule_position(molecule::Molecule, atom_index)
    molecule.positions[:, atom_index]
end

# Tests
using Test

@testset "Molecule" begin
    molecule = create_molecule("H2O", [Atom("H", 1.0), Atom("O", 16.0)], [1.0 2.0; 3.0 4.0], [0.0 0.0; 1.0 1.0])
    @test molecule.name == "H2O"
    @test length(molecule.atoms) == 2
    @test molecule.positions == [1.0 2.0; 3.0 4.0]
    @test molecule.velocities == [0.0 0.0; 1.0 1.0]

    @test get_atom_mass(molecule.atoms[1]) == 1.0
    @test get_molecule_position(molecule, 1) == [1.0, 2.0]
end