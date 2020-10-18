{ (5, 7) ----> (4, 6) 74 
   requires the address of array before, followed by n for n by n array and then the two coordinates
   returns value at that index and a copy of address }

: array_@ -1 rot * + 1- over swap + c@ ;

{ 1231423 10 5 7 ---> 32143 64 -----> 32145234 43252453+74}
