{ Made by Tanjim
  made on : 15/10/2020
  fixed on : 22/10/2020 }



{ (5, 7) ----> (4, 6) 74 
   requires the address of array before, followed by n for n by n array and then the two coordinates
   returns value at that index on stack }

: array_@ 1- 2 pick * over 1- + nip 2 pick + c@ nip nip ;

{ address n x y-1 ---> address n x y-1 n -----> address n x (y-1)n -----> address n x (y-1)n x -----> 
  address n x (y-1)n x-1 -----> address n x (y-1)n+x-1 -----> address n (y-1)n+x-1 
  -----> address n (y-1)n+x-1 address -----> address n (y-1)n+x-1*address }

{ minus 1 from y, times y by n, minus 1 from x, add those, then add to address}