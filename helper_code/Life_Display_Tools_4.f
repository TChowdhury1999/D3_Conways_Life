

{ ---------------- Life display by making and manipulating bmp's in memory -------------- } 


REQUIRES RND
 
400  constant world_x_size  { x size of the world matrix - MUST be a multiple of 4         }

400  constant world_y_size  { y size of the world matrix }

variable world_size         { Total number of world elements (World_x_size * World_y_size) }

variable Life_Array         { Holds starting address of ext-memory for array of life       } 

world_x_size world_y_size * World_size ! { Set up world_size = number of points in world   }

world_size @ 1 + cells Allocate drop Life_Array ! { Allocate memory for Array of life data }

variable bmp-address  { Stores start address of current bmp file             }

variable bmp-length   { Length in bytes of current bmp file including header }

variable bmp-header   { Length in bytes of current bmp header block          }

variable bmp-pointer  { Stores pointer to working address in bmp file        }

create Live_RGB_Cell 3 chars allot { 3 cell array to carry an RGB triplet color ( green, red, blue )  }

create Dead_RGB_Cell 3 chars allot { 3 cell array to carry an RGB triplet color ( green, red, blue )  }



: local>pixel ( x y -- world_index )         { Take an x-y cordinate pair and turn into a starting address} 
  world_x_size * 3 * swap 3 * +              { for the RGB element of a memory bmp                        }
  bmp-header @ +
;


: Random_life                                { Fill the life matrix with random 1's and 0's }
   world_y_size 0 do                     
    world_x_size 0 do                             
     2 rnd i j world_x_size * + Life_Array @ + c!
    loop
   loop
;



: Life                            { Main Life routine goes here                                        }
  Random_Life                     { Random fill for testing purposes - replace with your own routine   }
;



{ ---------------------------- Creating the bmp in memory ------------------------- }


: Make-Memory-Bmp ( -- address)          { Create a 24 bit (RGB) bitmap in memory                       } 
                                         { with world_x by world_y dimensions - return starting address }
  world_size @ 3 * 54 + chars allocate   { Allocate required memory 3 x size + header in chars          }
  drop bmp-address !

  world_size @ 3 * 54 + bmp-length !     { Store file length }
  54                    bmp-header !     { Sore header size  }


  bmp-length @  1 + 0 do           { Set all memory elements to zero initially }
  0 bmp-address @ i + c!
  loop

  66 bmp-address @ 0 + c!          { Create header entries - B      }
  77 bmp-address @ 1 + c!          { Create header entries - M      }
  54 bmp-address @ 10 + c!         { Header length 54 characters    } 
  40 bmp-address @ 14 + c!   
   1 bmp-address @ 26 + c!
  24 bmp-address @ 28 + c!         { Set bmp bit depth to 24        }
  48 bmp-address @ 34 + c!
 117 bmp-address @ 35 + c!
  19 bmp-address @ 38 + c!
  11 bmp-address @ 39 + c!
  19 bmp-address @ 42 + c!
  11 bmp-address @ 43 + c!
 
  world_size @ 3 * 54 + pad !      { Store file length in header as 32 bit Dword }
  pad     c@ bmp-address @ 2 + c! 
  pad 1 + c@ bmp-address @ 3 + c! 
  pad 2 + c@ bmp-address @ 4 + c! 
  pad 3 + c@ bmp-address @ 5 + c! 

  World_x_Size pad !               { Store bmp x dimension in header             }
  pad     c@ bmp-address @ 18 + c! 
  pad 1 + c@ bmp-address @ 19 + c! 
  pad 2 + c@ bmp-address @ 20 + c! 
  pad 3 + c@ bmp-address @ 21 + c! 

  World_y_Size pad !               { Store bmp y dimension in header             }
  pad     c@ bmp-address @ 22 + c! 
  pad 1 + c@ bmp-address @ 23 + c! 
  pad 2 + c@ bmp-address @ 24 + c! 
  pad 3 + c@ bmp-address @ 25 + c!
;




{ ------------------ Word to display BMP using Windows Calls ------------------  }
{                                                                                }
{                            Dont mess with this bit                             }


Function: SetDIBitsToDevice ( a b c d e f g h i j k l -- res )

: MEM-BMP ( addr -- )                 { Prints bmp starting at address to screen }
   [OBJECTS BITMAP MAKES BM OBJECTS]
   BM BMP!
   HWND GetDC ( hDC )
   DUP >R ( hDC ) 1 29 ( x y )        { (x,y) upper right corner of bitmap       }
   BM Width @ BM Height @ 0 0 0
   BM Height @ BM Data
   BM InfoHeader DIB_RGB_COLORS SetDIBitsToDevice DROP
   HWND R> ( hDC ) ReleaseDC DROP ;



{ --------------------------  Set BMP Stretch in Window -----------------------  }
{                                                                                }



Function: SetStretchBltMode ( a b -- res )

: Stretch-On
  HWND GetDC ( hDC )
  HALFTONE SetDIBitsToDevice drop
  ;







{ ------------------------- Words to define colors etc ------------------------  }



: live-cell-color            { Define RGB color for a living cell           }
  020 Live_RGB_Cell  2 + c!  
  255 Live_RGB_Cell  1 + c!
  020 Live_RGB_Cell      c!
;



: dead-cell-color            { Define RGB color for a dead cell             }
  020 Live_RGB_Cell  2 + c!  
  020 Live_RGB_Cell  1 + c!
  020 Live_RGB_Cell      c!
;



: Print-blanks { Print blank lines to avoid overwriting the BMP display }
  wipe 
  40 0 do cr   { Change this line to put default prompt in different    }
  loop ;       { positions below the bmp                                }


: Show-BMP
  bmp-address @ mem-bmp
;


: wipe-black                       { Set bmp file to solid black }
  bmp-length @ bmp-header @ 1 + do
  0 bmp-address @ 0 + i + c!
  0 bmp-address @ 1 + i + c!
  0 bmp-address @ 2 + i + c!
  3 +loop ;


: wipe-white                       { Set bmp file to solid white }
  bmp-length @ bmp-header @ 1 + do
  255 bmp-address @ 0 + i + c!
  255 bmp-address @ 1 + i + c!
  255 bmp-address @ 2 + i + c!
  3 +loop ;


: Life_to_BMP                                        { Write dead / live cells from life array into  }
   world_y_size 0 do                                 { BMP structuer held in memory                  }
    world_x_size 0 do
     i j local>pixel bmp-address @ + bmp-pointer !   { Find and store pointer to pixel in bmp file   }                       
     i j world_x_size * + Life_Array @ + C@          { Get a life element and check if alive or dead }
     0 = if                                          { Cell dead, color BMP pixel dead               }
      50     bmp-pointer @     c!
      50     bmp-pointer @ 1 + c!
      50     bmp-pointer @ 2 + c!
     else                                            { Cell alive, color BMP pixel alive             }
      0      bmp-pointer @     c!
      255    bmp-pointer @ 1 + c!
      0      bmp-pointer @ 2 + c!
     then
    loop
   loop
;

make-memory-bmp        { Create a BMP in memory to start with            }
wipe-black


: go Life life_to_bmp Print-blanks show-bmp ;

: go2 begin Life life_to_bmp show-bmp key? until Print-blanks show-bmp ;

go2


