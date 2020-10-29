{ Made by: Tanjim
  28/10/2020		}
 
{ contains a word run_100 which will iterate through 100 generations of Life without any graphics}

: run_100								{ proceeds through 100 generations}
	100 0 do 							{ loops from 0 to 99 (100 loops) }
	save_measurements
	copy_array_1_to_3
	copy_array_2_to_1  
	next_gen
	loop
;