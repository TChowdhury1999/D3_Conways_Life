{ Made by Tanjim
  22/10/2020}

{ address n fill_random ---> n by n array at address is filled with random numbers from 0 to 8 }
: fill_random square 0 do 9 rnd over i + c! loop ;
