{ Made by: Tanjim
  28/10/2020		}
 
{ contains words which iterate some number of generations of Life}
 
{ a word which will iterate through 100 generations of Life without any graphics}

: run_100								{ proceeds through 100 generations}
	100 0 do 							{ loops from 0 to 99 (100 loops) }
	save_measurements
	copy_array_1_to_3
	copy_array_2_to_1  
	next_gen
	loop
;

{ a word which will iterate though 10 generations of Life without any graphics}

: run_10								{ proceeds through 10 generations}
	10 0 do 							{ loops from 0 to 9 (10 loops) }
	save_measurements
	copy_array_1_to_3
	copy_array_2_to_1  
	next_gen
	loop
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