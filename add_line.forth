{ Made by Tanjim
  27/10/2020 }


{ puts a horizontal line of length a on life_array_1 from (x, y)
  required length a, followed by x, y 							}
  
: add_line														{ adds a line at x,y		}
	rot															{ put a at front of stack	}
	0 do														{ loop from 0 to a			}
		life_array_1 @ n @ 1 4 pick i + 4 pick					{ address, n, 1, x+i, y     }
		array_!													{ writes the 1 into array   }
	loop drop drop
;