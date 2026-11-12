program example_app
    use iso_fortran_env, only : real64
    use calculator_mod, only : add
    use statistics_mod, only : mean_value
    use physics_mod, only : kinetic_energy
    implicit none

    print '(a,i0)', '2 + 3 = ', add(2, 3)
    print '(a,f6.2)', 'Mean of [1,2,3] = ', mean_value([1.0_real64, 2.0_real64, 3.0_real64])
    print '(a,f6.2)', 'KE (2 kg at 3 m/s) = ', kinetic_energy(2.0_real64, 3.0_real64)
end program example_app
