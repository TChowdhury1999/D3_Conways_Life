{ Created by: Tanjim
  30/10/2020		}


{ This file contains all the words from files prefixed with 1_ to 11_
  Made so files do not need to be dragged into FORTH one by one       }




{ Contains short useful words used throughout the LIFE implementation } 

requires rnd

: square dup * ;													{ squares values}

: cube dup dup * * ;												{ cubes values}

: make_array square dup allocate drop dup rot 0 fill ;				{ makes arrays}

: array_@ 1- 2 pick * over 1- + nip 2 pick + c@ nip nip ;			{ fetches from arrays}

: array_! 1- 3 pick * + 1- 3 pick + c! drop drop ;					{ writes to arrays}

: show_array dup													{ shows arrays}
	square 0 
		do 
			dup i swap mod 0= if 
				cr cr
		then 
			over i + c@ 4 .R loop cr ;

: fill_random square 0 do 9 rnd over i + c! loop ;					{ fills arrays randomly from 0 to 8}

: fill_random_1s square 0 do 2 rnd over i + c! loop ;  				{ fills arrays randomly with 1s and 0s}
{ Made by : Tanjim Chowdhury}
{ 23/10/2020
  Updated: 28/10/2020		}

{ Initialise }

variable life_array_1								{ make life_array_1 variable				}
variable n 100 n !									{ save n 									}
n @ make_Array life_array_1 !						{ allocate memory to life_array_1			}
variable synchronicity 100 synchronicity ! 			{ make synchronicity variable, default 100	}
{ Created by: Tanjim Chowdhury
  26/10/2020				   }
  
 
variable generations								{ Which generations the simulation is on				}
0 generations !


variable cells_alive								{ Number of living cells in the current generation		}
0 cells_alive !

variable born										{ Number of cells born in the current generation		}
0 born !

variable died 										{ Number of cells that died since the last generation	}
0 died !

variable difference_array 							{ Creates an array that stores matrix difference between}
n @ make_array difference_array !				 	{ Allocate same bytes in this array as the rest			}

variable measurements_id							{ file id for where measurements will be saved 			}


: make_measurement_file 							{ creates measurements file and saves the file id }
	s" C:\Users\Tanjim\Desktop\Forth\files\data_hold\measurements.csv" 
	r/w create-file drop 										
	measurements_id !									
;

make_measurement_file

variable state 0 state !							{ make state variable and store 0			}
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

make_n_array																{ creates the neighbours_array}

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
{ Created by Tanjim Chowdhury
  20/10/2020         }


{ takes val from 0 to 8
  returns 0 if cell will always die
  returns 1 if cell will always be alive
  returns 2 if no effect }
  
: neighbour_rules                                  							
	case
		0 of 0 endof
		1 of 0 endof
		2 of 2 endof
		3 of 1 endof
		4 of 0 endof
		5 of 0 endof
		6 of 0 endof
		7 of 0 endof
		8 of 0 endof

	endcase ;

{ requires input of state (0 for dead, 1 for alive) then number of neighbours
  returns 0 if cell will be dead
  returns 1 if cell will be alive }

: apply_rules neighbour_rules
	case
		0 of 0 endof
		1 of 1 endof
		2 of dup endof
	endcase nip ;
	
{ Made by: Tanjim Chowdhury
  Made on: 23/10/2020               
  Edit on: 27/10/2020       }
  
{ Takes the address of life_array_1 and neighbours_array, 
  uses the apply_rules word to fill the next generation of Conway's Life in life_array_2}
  
{ Assumes variables called life_array_1, neighbours_array and n exist}

variable life_array_2												{ variable that stores life_array_2}
variable life_array_3												{ variable that stores life_array_3}
n @ make_array life_array_2 !										{ makes life array 2}
n @ make_array life_array_3 !										{ makes life array 3}

: apply_synchronicity												{ returns -1 synchronicity% of the time}
	100 rnd 1 + synchronicity @ <=									{ random number from 1 to 100 -> is x<?}
;


: fill_life_array_2													{ fills life array 2}
  n @ square 0														{ loop from 0 to n^2-1}
  do
	life_array_1 @ i + c@											{ adds current cell alive/dead to stack}
	neighbours_array @ i + c@										{ adds neighbours to stack}
	apply_rules														{ adds current cell alive/dead in next gen to stack}
	apply_synchronicity if											{ next step synchronicity% of the time}
		life_array_2 @ i + c!										{ saves 1/0 on stack to life_array_2}
    else drop
  then
  loop
;

: clear_life_array 													{ fills the life array with 0s}
	life_array_2 @ n @ square 0 fill
; 
{ Made by: Tanjim Chowdhury
  23/10/2020               }
  
{ Calculates life_array_2 using existing words then copies life_array_2 into life_array_1
  Requires variables life_array_1, life_array_2 and n
  Requires files array_words, make_neighbours_array, apply_rules and make_life_array_2}
  

: next_gen															{ use for gen>2 so you do not need to }
  fill_n_array														{ make the neighbour array and the 2nd}
  fill_life_array_2													{ life array each iteration           }
;

: copy_array_2_to_1
  life_array_2 @ life_array_1 @ n @ square move						{ copy life_array_2 to life_array_1   }
;

: copy_array_1_to_3
  life_array_1 @ life_array_3 @ n @ square move						{ copy life_array_2 to life_array_1   }
;

: show_l_array														{ word that shows life array 1 on console}
  life_array_2 @ n @ show_array drop drop
;

: next_gen_show														{ same as next_gen but also shows the }
  next_gen show_l_array												{ new life array on console           }
  drop drop
;
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









{ Created by : Tanjim 
  27/10/2020          }
  

{ takes address of two arrays and returns True (-1) if they are the same,
  and False (0) if they are different									
  Assumes arrays have dimensions n by n 								  }
  
: compare_arrays   												{ compares two arrays 				}
	-1															{ place a logical true on stack		}
	n @ square 0 do												{ loop from 0 to n^2				}
		2 pick i + c@ 2 pick i + c@ 							{ get the values for each array at 	}
		= not if												{ index i, then if they arent equal:}
			drop 0 												{ add a logical false				}
		then													{ else do nothing					}
	loop
	nip nip														{ remove the addresses, only True / }
	;															{ False left on stack 				}


{ 12345 54321 }
{ Created by: Tanjim Chowdhury
  26/10/2020
  Updated on: 28/10/2020		}
  
  
{ makes measurements on the life_array and stores it in variables}


: increment_generations												{ increments the generation number	}
	generations @ 													{ get the generation number			}
	1 + 															{ add one to the generation number  }
	generations !													{ store new value in generations	}
;

: count_alive   													{ counts number of alive cells in 	}
																	{ current generation 				}
	0																{ start of the count 				}
	n @ square 0 do													{ loop through the array 			}
		Life_Array_2 @ i + c@										{ put cell status on stack			}
		1 = if														{ checks if cell is alive 			}
			1 +									 					{ if so, adds one to stack			}
	then
    loop
  cells_alive !														{ write the count on stack to the 	}
																	{ variable							}									
;

: fill_difference_array												{ fills the difference array 		}
	n @ square 0 do													{ loops through the arrays			}
		life_array_1 @ i + c@ 										{ puts life_array_1 cell on stack   }
		life_array_2 @ i + c@ -	 									{ puts life_array_2 cell on stack   }
																	{ and finds the difference			}
		difference_array @ i + c!									{ difference into difference_array	}
   loop ;

: count_born_died													{ counts number of cells born/dead	}
	0 0																{ puts counts on stack 				}
	n @ square 0 do													{ loop through difference_array     }
		difference_array @ i + c@ 									{ get status of cell 				}
		case
			1 of 1 + endof											{ cell born, add one to born count  }
			255 of swap 1 + swap endof								{ cell died, add one to died count  }
		endcase
	loop
	born !
	died !
;	

: calculate_born_died												{ does above words in one word 		}		
	fill_difference_array
	count_born_died
;


: check_state														{ checks if LIFE has hit end state  }
	life_array_2 @ life_array_1 @ compare_arrays if					{ if array 2 == array 1: 			}
		1 state !													{ static state is saved				}
	else															{ else :							}
	
	life_array_2 @ life_array_3 @ compare_arrays if					{ if array 2 == array 3:			}
		2 state !													{ period 2 end state is saved 		}
	then
	then
;


: save_measurements													{ saves measurements to a csv file 	}
  increment_generations 											{ run the measurement words 		}
  count_alive
  calculate_born_died	
  check_state
	generations @ (.) measurements_id @ write-file drop				{ add generation number				}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	n @ (.) measurements_id @ write-file drop						{ adds n 							}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}	
	cells_alive @ (.) measurements_id @ write-file drop				{ add cells alive in current gen	}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	born @ (.) measurements_id @ write-file drop					{ add cells born in current gen		}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	died @ (.) measurements_id @ write-file drop					{ add cells that died since prev gen}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	state @ (.) measurements_id @ write-line drop					{ adds state and goes to next line	}
  0 born !															{ resets the born/died variables	}
  0 died ! 															
;

{ doesnt work}
: reset_all															{ resets so a new Life can start	}
	life_array_1 @ n @ square 0 fill								{ empties all arrays 				}
	life_array_2 @ n @ square 0 fill	
	life_array_3 @ n @ square 0 fill
	neighbours_array @ n @ square 0 fill
	measurements_id @ close-file drop								{ closes old measurement file		}
	make_measurement_file											{ creates new measurement file		}
	0 generations !													{ resets generation number			}
;

{ a word which will iterate though x generations of Life without any graphics}

: run_x									{ proceeds through x generations}
	0 do 								{ loops from 0 to x-1 (x loops) }
	save_measurements
	copy_array_1_to_3
	copy_array_2_to_1  
	next_gen
	loop
;
