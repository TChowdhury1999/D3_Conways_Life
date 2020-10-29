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
	99 rnd 1 + synchronicity @ <=
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