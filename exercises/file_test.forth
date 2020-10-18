{ Write a set of words to create a file, write the numbers 20 to 40 and their
squares and cubes to the file in sets of three numbers per line, and then close the file.
Find a method of reading this file into a spreadsheet such as Excel or Origin for data
plotting. }


{ Create File
  20 20^2 20^3 CR from 20 to 40
  close}

  
variable test_file_id

: make_test_file s" C:\Users\Tanjim\Desktop\Forth\files\test_file.dat" r/w create-file drop test_file_id ! ;

: write_square_cube                                       
  41 20 do                                                  
  i (.)     test_file_id @ write-file drop
  s"  "     test_file_id @ write-file drop
  i square (.) test_file_id @ write-file drop
  s"  "     test_file_id @ write-file drop
  i cube (.) test_file_id @ write-line drop
  loop
;

: close-test-file test_file_id @ close-file drop ;

: file_test 
  make_test_file
  write_square_cube    
  close-test-file ;
