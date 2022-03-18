=begin
######Polynomials#####
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
=end
=cut

sub polynomial_eval{
    #print("Evalulating Polynomial\n");
    #provide a poly array reference
    my $ref = $_[0];
   # print("Reference: $ref\n");
    my @poly = @$ref;
    #print("Polynomial: @poly\n");
    #provide an input to evalulate at
    my $x = $_[1];
    #print("Input: $x\n");
    #start the output at the constant value
    my $output = $poly[0];
    #Get the degree of poly
    my $degree = @poly-1;
    #print("Degree: $degree\n");
    for(my $i=1; $i<=$degree; $i = $i+1){
        #print("$poly[$i], $x\n");
        $output = $output + $poly[$i]*$x**$i;
    }
    #print("Output: $output\n");
    return $output;
}
sub polynomial_add{
    my $a_ref = $_[0];
    my $b_ref = $_[1];
    my @A = @$a_ref;
    my @B = @$b_ref;
    #my $n = @B<@A?@B:@A;
    my $m = @B<@A?@A:@B;
;
    my @result = ();
    for(my $i = 0;$i<$m;$i = $i+1){
        $result[$i] = $A[$i]+$B[$i];
    }
    #print("Result: @result\n");
    return \@result;
}
sub polynomial_multiply{
    my $a_ref = $_[0];
    my $b_ref = $_[1];
    my @A = @$a_ref;
    my @B = @$b_ref;
    my $nA = @A;
    my $nB = @B;
    my @result = (0);
    for(my $i = 0; $i<$nA; $i = $i+1){
        my @temp = (0);
        for(my $j = 0; $j<$nB; $j= $j+1){
            $temp[$j+$i]= $A[$i]*$B[$j];
        }
        my $ref = polynomial_add(\@temp,\@result);
        @result = @$ref;
    }
    #print("Result: @result\n");
    return \@result;
}
sub str_sign{
    my $result =$_[0]<0?"-":"+";
    if($_[0] == 0){
        return "";
    }
    return $result;
}

sub polynomial_latex{
   my $ref = $_[0];
   my @poly = @$ref;
   print("poly: @poly\n");
   my $n = @poly;
   my $result = "";
   for(my $i = $n-1; 0<=$i; $i = $i-1){
       if($poly[$i] == 0){
           next;
       }
       my $pow = $i;
       my $coef = abs($poly[$i]);
       my $sign = str_sign($poly[$i]);
       if($i == $n-1){
           $sign = "";
       }
       if($coef == 1 && 0<$i){
           $coef = "";
       }
       
       
       #print("$result $sign $coef x^{$pow}");
       if( 1 < $pow){
        $result = "$result $sign $coef x^{$pow}";   
       }elsif($pow == 1){
           $result = "$result $sign $coef x";
       }
       else{
           $result = "$result $sign $coef";
       }
       
   }
   return $result;
}

sub polynomial_from_zeros{
    my $ref = $_[0];
    my @zeros = @$ref;
    my $n = @zeros;
    my @result = (-$zeros[0],1);
    for(my $i = 1; $i<$n; $i = $i+1){
        my @p2 = (-$zeros[$i],1);
        my $ref = polynomial_multiply(\@result,\@p2);
        @result = @$ref;
    }
    return \@result;
}

sub polynomial_derivative{
    my @poly = @{$_[0]};
    my $n = @poly;
    my @result = ();
    for(my $i=$n-1; 1<=$i; $i = $i - 1){
        $result[$i-1]=$poly[$i]*$i; 
    }
    return \@result;
}

sub polynomial_integrate{
    my @poly = @{$_[0]};
    #must provide a constant for the integration (cannot leave it symbolic)
    my $C = $_[1];
    my $n = @poly;
    my @result = ($C);
    for(my $i=1; $i<=$n; $i = $i +1){
        $result[$i]=$poly[$i-1]/$i; 
    }
    return \@result;
}

sub complex_add{
    my @a = @{$_[0]};
    my @b = @{$_[1]};
    my @result = ($a[0]+$b[0],$a[1]+$b[1]);
    return \@result;
}

sub complex_multiply{
    my @a = @{$_[0]};
    my @b = @{$_[1]};
    my @result = ($a[0]*$b[0]-$a[1]*$b[1],$a[0]*$b[1]+$a[1]*$b[0]);
    return \@result;
}

sub complex_pow{
   my @a = @{$_[0]};
   my $n = $_[1];
   my @result = (1,0);
   for(my $i = 0; $i<$n; $i=$i+1){
      @result = @{complex_multiply(\@result,\@a)};
   }
   return \@result;
}

sub complex_conjugate{
    my @a = @{$_[0]};
    my @result = ($a[0],-$a[1]);
    return \@result;
}
sub complex_reciprocal{
    my @a = @{$_[0]};
    my @ac = @{complex_conjugate(\@a)};
    my @temp = @{complex_multiply(\@a,\@ac)};
    if($temp[0] == 0){
        return undef;
    }
    my @result = ($ac[0]/$temp[0],$ac[1]/$temp[0]);
    return \@result
}

sub complex_modulus{
    return sqrt($_[0]**2 + $_[1]**2);
}

sub complex_polynomial_eval{
    # f(z) = result
    my @poly = @{$_[0]};
    my @z = @{$_[1]};
    
    }


###In progress A-E Method for root solving. Downside: requires complex polynomials###
sub aberth_erlich_method{
    my @poly = @{$_[0]};
    my $n = @poly;
    
    sub f{
        return polynomial_eval(\@poly,$_[0]);
    }
    
    sub df{
        
    }
}
