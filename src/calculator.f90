module calculator_mod
    implicit none
    private
    public :: add, square, is_even
contains
    pure integer function add(a, b)
        integer, intent(in) :: a, b
        add = a + b
    end function add

    pure integer function square(x)
        integer, intent(in) :: x
        square = x * x
    end function square

    pure logical function is_even(x)
        integer, intent(in) :: x
        is_even = mod(x, 2) == 0
    end function is_even
end module calculator_mod
