{ Made by: Tanjim Chowdhury
  23/10/2020                }


{ takes n by n life_array_1 with 8 bit data ---> returns equivalent array but with 32 bit data  }
{ have variable life_array_1 and n																}
{ creates a 32bit array 																		}

variable life_array_32_bit												{ creates the 32 bit array	}
n @ 2 * cells make_array												{ (2n)^2 = 4n^2 bytes needed}
life_array_32_bit !														{ saves address to variable }


: fill_life_array_32_bit 												{ fills the 32 bit array	}
  n @ square 0 															{ loop from 0 to n^2		}
  do 
	life_array_2 @ i + c@												{ get ith value from life_array_2}
	life_array_32_bit @ i cells + !										{ save this value into 32 bit 	 }
  loop																	{ loop 							 }
;


: show_array_32_bit														{ shows 32 bit life array on console}
	n @ square 0														{ loop from 0 to n^2				}
		do
			i n @ mod 0= if												{ if i is multiple of n, next line  }
				cr cr
		then
			life_array_32_bit @ i cells + @ 4 .R 						{ prints each element from 32 bit   }
		loop cr															{ array                             }
;
