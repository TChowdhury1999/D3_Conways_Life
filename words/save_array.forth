{ Created by Tanjim Chowdhury
  22/10/2020         }

{ WILL NEED TO BE CHANGED}
  
  
{ Save array as file
  Requires address and n }

variable id 

: make_array_file                                
  s" C:\Users\Tanjim\Desktop\Forth\files\data_hold\array.dat" r/w create-file drop 
  id !                                 
;

: write_array_file dup square 0 do
	dup i swap mod 0= if
		s" " id @ write-line drop
	then 
		over i + c@ (.) id @ write-file drop
		s"  " id @ write-file drop
	loop cr ;

: save_array
	make_array_file
	write_array_file 
	;

{ 15615616 10 ----> 42313253 10 over}