{ Created by: Tanjim}

{ Contains all the array words in one file } 

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
