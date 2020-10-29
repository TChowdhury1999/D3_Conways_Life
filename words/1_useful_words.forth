{ Created by: Tanjim}

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
