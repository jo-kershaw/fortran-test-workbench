program manual_tests
    use iso_fortran_env, only : real64
    use calculator_mod, only : add, square, is_even
    use statistics_mod, only : mean_value, population_variance
    use physics_mod, only : kinetic_energy, speed_3d
    implicit none
    integer :: tests_run, failures

    tests_run = 0
    failures = 0

    call check_int('add positive', add(2, 3), 5)
    call check_int('add negative', add(-3, 1), -2)
    call check_int('square negative', square(-4), 16)
    call check_true('zero is even', is_even(0))
    call check_true('three is not even', .not. is_even(3))
    call check_real('mean', mean_value([1.0_real64, 2.0_real64, 3.0_real64]), &
        2.0_real64, 1.0e-12_real64)
    call check_real('variance', population_variance([1.0_real64, 2.0_real64, 3.0_real64]), &
        2.0_real64 / 3.0_real64, 1.0e-12_real64)
    call check_real('kinetic energy', kinetic_energy(2.0_real64, 3.0_real64), &
        9.0_real64, 1.0e-12_real64)
    call check_real('kinetic energy sign of velocity', kinetic_energy(2.0_real64, -3.0_real64), &
        9.0_real64, 1.0e-12_real64)
    call check_real('speed 3-4-0', speed_3d([3.0_real64, 4.0_real64, 0.0_real64]), &
        5.0_real64, 1.0e-12_real64)

    print '(i0,a,i0,a)', tests_run - failures, ' / ', tests_run, ' tests passed'
    if (failures /= 0) error stop 1

contains
    subroutine check_int(label, actual, expected)
        character(len=*), intent(in) :: label
        integer, intent(in) :: actual, expected
        tests_run = tests_run + 1
        if (actual /= expected) then
            print '(a,a,a,i0,a,i0)', 'FAIL: ', label, ' expected ', expected, ', got ', actual
            failures = failures + 1
        else
            print '(a,a)', 'PASS: ', label
        end if
    end subroutine check_int

    subroutine check_true(label, condition)
        character(len=*), intent(in) :: label
        logical, intent(in) :: condition
        tests_run = tests_run + 1
        if (.not. condition) then
            print '(a,a)', 'FAIL: ', label
            failures = failures + 1
        else
            print '(a,a)', 'PASS: ', label
        end if
    end subroutine check_true

    subroutine check_real(label, actual, expected, tolerance)
        character(len=*), intent(in) :: label
        real(real64), intent(in) :: actual, expected, tolerance
        tests_run = tests_run + 1
        if (.not. (abs(actual - expected) <= tolerance)) then
            print '(a,a,a,es13.5,a,es13.5)', 'FAIL: ', label, &
                ' expected ', expected, ', got ', actual
            failures = failures + 1
        else
            print '(a,a)', 'PASS: ', label
        end if
    end subroutine check_real
end program manual_tests
