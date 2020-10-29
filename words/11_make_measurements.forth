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



