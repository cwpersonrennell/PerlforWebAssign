# PerlforWebAssign

Given an list (c0, c1, c2, c3, ...), the following methods will treat the list as if it were a polynomial c0 + c1 x +c2 x^2 +c3 x^3 ....
Subroutine: polynomial_eval(\@poly,$x)

Inputs: Reference to list containing polynomial coefficients, real input value.
Outputs: Real output value of polynomial function
Subroutine: polynomial_add(\@a, \@b)

Inputs: Two references to lists of coefficients
Outputs: Reference to new list of coefficients which is the polynomial sum.
Example usage:
   @a = (1,0,1) #1 + x^2
   @b = (1,1)   #1 + x
   @c = @{polynomial_add(\@a,\@b)}   # 2 + x + x^2
   #Note the use of @{} around the function will convert the reference back to a list. This is a nuance of perl which is required since functions can only return numerical values or references.
Subroutine: polynomial_multiply(\@a, \@b)
Inputs: Two references to lists of coefficients
Outputs: Reference to new list of coefficients which is the polynomial product.
Subroutine: polynomial_from_zeros(\@zeros)
Inputs: Single reference to list of coefficients
Outputs: Reference to new list of coefficients which is the polynomial derived from the zeros provided. Chooses 1 as leading coefficient.
Subroutine: polynomial_derivative(\@poly)
Inputs: Reference to lists of coefficients
Outputs: Reference to new list of coefficients which is the polynomial derivative of the input.
Subroutine: polynomial_integrate(\@poly,$C)
Inputs: Reference to lists of coefficients, real C value to use for integration
Outputs: Reference to new list of coefficients which is the polynomial integration of the input with C as the constant chosen.
Subroutine: polynomial_latex(\@poly)
Inputs: Reference to list of coefficients
Outputs: LaTex styled string of the standard cn x^n + c(n-1) x^{x-1} + ... + c1 x + c0 representation of a polynomial

