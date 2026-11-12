module finite_difference_mod
    use iso_fortran_env, only : real64
    implicit none
    private
    public :: first_derivative
contains
    ! Approximate dy/dx on a UNIFORMLY spaced 1D grid.
    ! Central differences in the interior; one-sided at the ends.
    ! Preconditions: size(y) >= 2 and dx > 0.
    pure function first_derivative(y, dx) result(dydx)
        real(real64), intent(in) :: y(:), dx
        real(real64) :: dydx(size(y))
        integer :: i, n

        n = size(y)
        dydx(1) = (y(2) - y(1)) / dx
        do i = 2, n - 1
            dydx(i) = (y(i+1) - y(i-1)) / (2.0_real64 * dx)
        end do
        dydx(n) = (y(n) - y(n-1)) / dx
    end function first_derivative
end module finite_difference_mod
