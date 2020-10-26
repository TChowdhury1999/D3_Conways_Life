requires rnd

: square dup * ;

: cube dup dup * * ;

: make_array square dup allocate drop dup rot 0 fill ;

: array_@ 1- 2 pick * over 1- + nip 2 pick + c@ nip nip ;

: array_! 1- 3 pick * + 1- 3 pick + c! drop drop ;

: show_array dup
	square 0 
		do 
			dup i swap mod 0= if 
				cr cr
		then 
			over i + c@ 4 .R loop cr ;

: fill_random square 0 do 9 rnd over i + c! loop ;

: fill_random_1s square 0 do 2 rnd over i + c! loop ;

variable life_array_1								{ make life_array_1 variable				}
variable n 5 n !									{ save n 									}
n @ make_Array life_array_1 !						{ allocate memory to life_array_1			}

variable generations								{ Which generations the simulation is on				}
0 generations !

variable cells_alive_1								{ Number of living cells in the previous generation		}
0 cells_alive_1 !

variable cells_alive_2								{ Number of living cells in the current generation		}
0 cells_alive_2 !

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

variable life_array_2


: make_life_array_2 												{ makes life array 2}
  n @ make_array 
  life_array_2 !
;

make_life_array_2													{ makes life_array_2}


: fill_life_array_2													{ fills life array 2}
  n @ square 0														{ loop from 0 to n^2-1}
  do
	life_array_1 @ i + c@											{ adds current cell alive/dead to stack}
	neighbours_array @ i + c@										{ adds neighbours to stack}
	apply_rules														{ adds current cell alive/dead in next gen to stack}
	life_array_2 @ i + c!											{ saves 1/0 on stack to life_array_2}
  loop
;

: clear_life_array 													{ fills the life array with 0s}
	life_array_1 @ n @ square 0 fill
;

: second_gen 														{ use when calculating second generation}
  make_n_array														{ create and fill neighbour array       }
  fill_n_array
  make_life_array_2													{ create and fill life_array_2          }
  fill_life_array_2
  life_array_2 @ life_array_1 @ n @ square move						{ copy life_array_2 to life_array_1     }
;

: next_gen															{ use for gen>2 so you do not need to }
  fill_n_array														{ make the neighbour array and the 2nd}
  fill_life_array_2													{ life array each iteration           }
;

: copy_array_2_to_1
  life_array_2 @ life_array_1 @ n @ square move						{ copy life_array_2 to life_array_1   }
;

: show_l_array														{ word that shows life array 1 on console}
  life_array_1 @ n @ show_array drop drop
;

: next_gen_show														{ same as next_gen but also shows the }
  next_gen show_l_array												{ new life array on console           }
  drop drop
;

variable life_array_32_bit												{ creates the 32 bit array	}
n @ 2 * cells make_array												{ (2n)^2 = 4n^2 bytes needed}
life_array_32_bit !														{ saves address to variable }


: fill_life_array_32_bit 												{ fills the 32 bit array	}
  n @ square 0 															{ loop from 0 to n^2		}
  do 
	life_array_1 @ i + c@												{ get ith value from life_array_1}
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
: increment_generations												{ increments the generation number	}
	generations @ 													{ get the generation number			}
	1 + 															{ add one to the generation number  }
	generations !													{ store new value in generations	}
;

: count_alive_1 													{ counts number of alive cells in 	}
																	{ previous generation 				}
	0																{ start of the count 				}
	n @ square 0 do													{ loop through the array 			}
		Life_Array_1 @ i + c@										{ put cell status on stack			}
		1 = if														{ checks if cell is alive 			}
			1 +									 					{ if so, adds one to stack			}
	then
    loop
  cells_alive_1 !													{ write the count on stack to the 	}
																	{ variable							}									
;

: count_alive_2 													{ counts number of alive cells in 	}
																	{ current generation 				}
	0																{ start of the count 				}
	n @ square 0 do													{ loop through the array 			}
		Life_Array_2 @ i + c@										{ put cell status on stack			}
		1 = if														{ checks if cell is alive 			}
			1 +									 					{ if so, adds one to stack			}
	then
    loop
  cells_alive_2 !													{ write the count on stack to the 	}
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

: save_measurements													{ saves measurements to a csv file 	}
  increment_generations 											{ run the measurement words 		}
  count_alive_1 count_alive_2 
  calculate_born_died	
	generations @ (.) measurements_id @ write-file drop				{ add generation number				}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	cells_alive_1 @ (.) measurements_id @ write-file drop			{ add cells alive in prev gen		}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	cells_alive_2 @ (.) measurements_id @ write-file drop			{ add cells alive in current gen	}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	born @ (.) measurements_id @ write-file drop					{ add cells born in current gen		}
	s" , " measurements_id @ write-file drop						{ adds comma and space				}
	died @ (.) measurements_id @ write-line drop					{ add cells that died since prev gen}
  0 born !															{ resets the born/died variables	}
  0 died ! 															
;


