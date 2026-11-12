module statistics_mod
    use iso_fortran_env, only : real64
    implicit none
    private
    public :: mean_value, population_variance
contains
    ! Precondition: values is not empty.
    pure real(real64) function mean_value(values)
        real(real64), intent(in) :: values(:)
        mean_value = sum(values) / real(size(values), real64)
    end function mean_value

    ! Population variance, i.e. divide by N (not N-1).
    ! Precondition: values is not empty.
    pure real(real64) function population_variance(values)
        real(real64), intent(in) :: values(:)
        real(real64) :: mu
        mu = mean_value(values)
        population_variance = sum((values - mu)**2) / real(size(values), real64)
    end function population_variance
end module statistics_mod
