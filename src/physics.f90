module physics_mod
    use iso_fortran_env, only : real64
    implicit none
    private
    public :: kinetic_energy, speed_3d
contains
    ! Mass in kg, velocity in m/s, result in joules.
    ! Precondition: mass >= 0.
    pure real(real64) function kinetic_energy(mass, velocity)
        real(real64), intent(in) :: mass, velocity
        kinetic_energy = 0.5_real64 * mass * velocity**2
    end function kinetic_energy

    ! Magnitude of a 3D velocity vector in m/s.
    pure real(real64) function speed_3d(v)
        real(real64), intent(in) :: v(3)
        speed_3d = sqrt(sum(v**2))
    end function speed_3d
end module physics_mod
