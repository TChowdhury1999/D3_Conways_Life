{ Created by Tanjim Chowdhury
  15/10/2020         }


{ 124325243 10
   requires the address of array before and its size (n for n by n), 
   puts numbers 1 to n^2 in array and leaves the address in stack }

{ : linear_array dup square 1 do i . loop cr ; }
   
   
: linear_array dup square 1 + 1 do 
	i dup 1- 3 pick + c! 
loop cr ;
