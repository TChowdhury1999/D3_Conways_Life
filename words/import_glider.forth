{ Made by: Tanjim Chowdhury
  23/10/2020               }
  
{ Puts a glider into the life_array_1 with x, y at top-left corner }
{ requires variable n and life_array_1 and word array_!            }

variable glider_x
variable glider_y  

: import_glider
  glider_y !
  glider_x !														{ saves x,y into the variables  }
  life_array_1 @ n @ 1 glider_x @ 2 + glider_y @ array_!			{ changes values in life_array_1}
  life_array_1 @ n @ 1 glider_x @ glider_y @ 1 + array_!			{ so a glider appears in the top}
  life_array_1 @ n @ 1 glider_x @ 2 + glider_y @ 1 + array_!		{ left corner                   }
  life_array_1 @ n @ 1 glider_x @ 1 + glider_y @ 2 + array_!
  life_array_1 @ n @ 1 glider_x @ 2 + glider_y @ 2 + array_!		
;