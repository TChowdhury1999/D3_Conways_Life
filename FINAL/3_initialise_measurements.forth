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