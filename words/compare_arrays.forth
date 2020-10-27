{ Created by : Tanjim 
  27/10/2020          }
  

{ takes address of two arrays and returns True (-1) if they are the same,
  and False (0) if they are different									
  Assumes arrays have dimensions n by n 								  }
  
: compare_arrays   												{ compares two arrays 				}
	-1															{ place a logical true on stack		}
	n @ square 0 do												{ loop from 0 to n^2				}
		2 pick i + @ 2 pick i + @ 								{ get the values for each array at 	}
		= not if												{ index i, then if they arent equal:}
			drop 0 												{ add a logical false				}
		then													{ else do nothing					}
	loop
	nip nip														{ remove the addresses, only True / }
	;															{ False left on stack 				}


{ 12345 54321 }