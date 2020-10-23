{ Made by Tanjim
  15/10/2020 }


{ 124325243 10
   requires the address of array before and its size (n for n by n), 
   outputs values in array and leaves the address in stack }

: show_array dup
	square 0 
		do 
			dup i swap mod 0= if 
				cr cr
		then 
			over i + c@ 4 .R loop cr ;

{ loop from 0 to 99 : if i is multiple of n, cr cr 
					  then fetch value, print with 2 .R}
					
{ 3214324 10
	dup }