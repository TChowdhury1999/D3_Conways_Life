{ Contains all the array words in one file } 

: square dup * ;

: make_array square dup allocate drop dup rot 0 fill ;

: array_@ -1 rot * + 1- over swap + c@ ;

: array_! 1- 3 pick * + 1- 3 pick + c! drop ;

: show_array dup
	square 0 
		do 
			dup i swap mod 0= if 
				cr cr
		then 
			over i + c@ 4 .R loop cr ;

