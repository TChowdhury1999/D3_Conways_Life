{ Created by Tanjim Chowdhury
  22/10/2020         }


{ Read a file and save into address
  Requires n for n by n array }

variable id 
dup make_array                                                                         { puts address on stack }

: open_array_file
  s" C:\Users\Tanjim\Desktop\Forth\files\seeds\test_seed.dat" r/w open-file drop   { saves the file id }
  id !                                 
;



{ read-file requires address u1 consecutive numbers and fileid, then 2 drops}

: read_array_file                                
  { swap }																			   { swaps address and n }
  { square 2 * 1 + }																   { amount of characters
																					 read                }
  id @ read-file drop drop                              
;

: read_Array
  open_array_file
  read_array_file
;

{ 15615616 10 ----> 42313253 10 over}