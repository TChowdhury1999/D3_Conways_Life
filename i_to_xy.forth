{ Made by Tanjim
  made on : 22/10/2020 }

{ 
   converts index i to coordinates for n by n grid --> (x,y)
   requires variable n and input index i and leaves two values: x, y on stack }

   
   
: i_to_xy dup n @ / 1+ over n @ mod 1+ swap rot drop ;

{ i --> i, i -->  i, y -->i, y, i -->i, y, x -->i, x, y --> x, y}

{ i , i/n + 1 = y, i mod n + 1 = x}

{ example: 
  i = 53  ----> (4, 6) for n = 10} 