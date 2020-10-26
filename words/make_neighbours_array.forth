{ Made by Tanjim
  22/10/2020 }
  
{ Takes address of life_array_1 and n (for n by n array)
  Assumes life_array_1 is stored in variable life_array_1
  Assumes n is stored in variable n
  Creates a n by n array called neighbours_array and puts in number of cells for each
  index of the life_array_1 }
  
{ ON STACK: }

variable neighbours_array
variable index_x
variable index_y

: i_to_xy dup n @ / 1+ over n @ mod 1+ swap rot drop ;

: make_n_array 															{ makes and stores the neighbours}
  n @ make_array 														{ array                          }
  neighbours_array !
;

{ ON STACK: }

: show_n_array
  neighbours_array @ n @ show_array
;

: fill_n_array
  n @ square 0																{ loop from 0 to n^2-1}
  do 
  i i_to_xy index_y ! index_x !												{ saves coordinates into x y}					
  
  index_y @ 1 = if															{ checks if y = 1 }

	index_x @ 1 = if														{ checks if top left corner}
		life_array_1 @ n @ index_x @ 1+ index_y @ array_@  					{ places number to right on stack}
		life_array_1 @ n @ index_x @ index_y @ 1+ array_@  					{ places number beneath on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1+ array_@  				{ places number diagonal right beneath on stack}
		+ +																	{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
	index_x @ n @ = if														{ checks if top right corner}
		life_array_1 @ n @ index_x @ 1- index_y @ array_@  					{ places number to left on stack}
		life_array_1 @ n @ index_x @ index_y @ 1+ array_@  					{ places number beneath on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1+ array_@  				{ places number diagonal left beneath on stack}
		+ +																	{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
	index_x @ 1 = not index_x @ n @ = not and if 							{ checks if not corner}
		life_array_1 @ n @ index_x @ 1+ index_y @ array_@  					{ places number to right on stack}
		life_array_1 @ n @ index_x @ index_y @ 1+ array_@  					{ places number beneath on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1+ array_@  				{ places number diagonal right beneath on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ array_@  					{ places number to left on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1+ array_@  				{ places number diagonal left beneath on stack}
		+ + + +																{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
  else
  
  index_y @ n @ = if														{ checks if y = n}	

	index_x @ 1 = if														{ checks if bottom left corner}
		life_array_1 @ n @ index_x @ 1+ index_y @ array_@  					{ places number to right on stack}
		life_array_1 @ n @ index_x @ index_y @ 1- array_@  					{ places number above on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1- array_@  				{ places number diagonal right above on stack}
		+ +																	{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
	index_x @ n @ = if														{ checks if bottom right corner}
		life_array_1 @ n @ index_x @ 1- index_y @ array_@  					{ places number to left on stack}
		life_array_1 @ n @ index_x @ index_y @ 1- array_@  					{ places number above on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1- array_@  				{ places number diagonal left above on stack}
		+ +																	{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
	index_x @ 1 = not index_x @ n @ = not and if 							{ checks if not corner}
		life_array_1 @ n @ index_x @ 1+ index_y @ array_@  					{ places number to right on stack}
		life_array_1 @ n @ index_x @ index_y @ 1- array_@  					{ places number above on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1- array_@  				{ places number diagonal right above on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ array_@  					{ places number to left on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1- array_@  				{ places number diagonal left above on stack}
		+ + + +																{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
  else

  index_x @ 1 = if															{ checks if x = 1}
	
	index_y @ 1 = not index_y @ n @ = not and if 							{ checks if not corner}
		life_array_1 @ n @ index_x @ 1+ index_y @ array_@  					{ places number to right on stack}
		life_array_1 @ n @ index_x @ index_y @ 1- array_@  					{ places number above on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1- array_@  				{ places number diagonal right above on stack}
		life_array_1 @ n @ index_x @ index_y @ 1+ array_@  					{ places number beneath on stack}
		life_array_1 @ n @ index_x @ 1+ index_y @ 1+ array_@  				{ places number diagonal right beneath on stack}
		+ + + +																{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
  else

  index_x @ n @ = if														{ checks if x = n}
	
	index_y @ 1 = not index_y @ n @ = not and if 							{ checks if not corner}
		life_array_1 @ n @ index_x @ 1- index_y @ array_@  					{ places number to left on stack}
		life_array_1 @ n @ index_x @ index_y @ 1- array_@  					{ places number above on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1+ array_@  				{ places number diagonal left beneath on stack}
		life_array_1 @ n @ index_x @ index_y @ 1+ array_@  					{ places number beneath on stack}
		life_array_1 @ n @ index_x @ 1- index_y @ 1- array_@  				{ places number diagonal left above on stack}
		+ + + +																{ sums neighbours}
		neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
	then
  else																		{ Cell being checked is not a corner or edge cell}


  	life_array_1 @ n @ index_x @ 1+ index_y @ array_@  						{ places number to right on stack}
	life_array_1 @ n @ index_x @ 1+ index_y @ 1+ array_@  					{ places number diagonal right beneath on stack}
	life_array_1 @ n @ index_x @ index_y @ 1+ array_@  						{ places number beneath on stack}
	life_array_1 @ n @ index_x @ 1- index_y @ 1+ array_@  					{ places number diagonal left beneath on stack}
	life_array_1 @ n @ index_x @ 1- index_y @ array_@  						{ places number to left on stack}
	life_array_1 @ n @ index_x @ 1- index_y @ 1- array_@  					{ places number diagonal left above on stack}
	life_array_1 @ n @ index_x @ index_y @ 1- array_@  						{ places number above on stack}
	life_array_1 @ n @ index_x @ 1+ index_y @ 1- array_@  					{ places number diagonal right above on stack}
	+ + + + + + +
	neighbours_array @ n @ rot index_x @ index_y @ array_!				{ places sum into neighbours_array}
 
  then then then then
  loop ;