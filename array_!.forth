{ Made by Tanjim
  15/10/2020 }

{ 124325243 10 21 (1, 4) ----> puts 21 into memory block 


   requires the address of array before and its size (n for n by n), 
   followed by value to put in and then the two coordinates
   
   put ur value in that coordinate}

: array_! 1- 3 pick * + 1- 3 pick + c! drop drop ;

{ 1234324 10 21 1 4 ---> 1233424 10 21 40 ----> 34214321 10 21 543125413 }