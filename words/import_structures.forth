{ Made by Tanjim
  27/10/2020 }


{ puts a horizontal line of length a on life_array_2 from (x, y)
  required length a, followed by x, y 							}
  
: import_line													{ adds a line at x,y		}
	rot															{ put a at front of stack	}
	0 do														{ loop from 0 to a			}
		life_array_2 @ n @ 1 4 pick i + 4 pick					{ address, n, 1, x+i, y     }
		array_!													{ writes the 1 into array   }
	loop drop drop
;


{ Puts a glider into the life_array_2 with x, y at top-left corner }
{ requires variable n and life_array_2 and word array_!            }

variable glider_x
variable glider_y  

: import_glider
  glider_y !
  glider_x !														{ saves x,y into the variables  }
  life_array_2 @ n @ 1 glider_x @ 2 + glider_y @ array_!			{ changes values in life_array_1}
  life_array_2 @ n @ 1 glider_x @ glider_y @ 1 + array_!			{ so a glider appears in the top}
  life_array_2 @ n @ 1 glider_x @ 2 + glider_y @ 1 + array_!		{ left corner                   }
  life_array_2 @ n @ 1 glider_x @ 1 + glider_y @ 2 + array_!
  life_array_2 @ n @ 1 glider_x @ 2 + glider_y @ 2 + array_!		
;

{ Puts a square into life_array_2 with x, y at top-left corner
  required x y before the word									}
  
: import_square														{ imports a square at x y	}
	2 2 pick 2 pick													{ puts 2 x y on stack 	 	}
	import_line														{ puts a 2 long line at x y }
	2 2 pick 2 pick 1 +												{ puts 2 x y+1 on stack		}
	import_line														{ puts another line below 	}
	drop drop
;


: reset_l_array										{ Word to reset life_array_2 to all 0's}
  life_array_2 @ n @ square 0 fill  							
;









