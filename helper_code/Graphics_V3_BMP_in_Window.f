
{ ---------------------------------------------------------------------------------------- }
{                                                                                          }
{ Words to create bitmap image files ( .bmp) in memory and display them as part of         } 
{ a real time data visualisation routine.                                                  }
{                                                                                          }
{ This version prints the .bmp into a window separate from the console, requiring so       }
{ additional operating system specific (Windows, Mac OSX etc) code to build and "talk"     }
{ to the new window.                                                                       }
{                                                                                          }
{ Note that bmp x sizes must be integer divisible by 4 to avoid display glitches without   }
{ padding line ends - this is a general feature of the bmp file format and is not codes    }
{ spescific.  bmp x sizes will be rounded down to the nearest factor of 4.                 }
{                                                                                          }
{          Roland Smith, revised 11/10/2020 For 3rd Year Lab D3 Experiment                 }
{                                                                                          }
{                                                                                          }
{ ---------------------------------------------------------------------------------------- }

REQUIRES ..\..\RND              { Load random numbers module }

1 IMPORT: DrawMenuBar           { <n> = number of parameters to be passed to function }
1 IMPORT: IsWindow
4 IMPORT: DefMDIChildProc
5 IMPORT: DefFrameProc


0 Constant Update_Timer   { Sets windows update rate               }

200  constant BMP_x_size  { x size of BMP File                     } 

200  constant BMP_y_size  { y size of BMP File                     }

variable BMP_size         { Total number of BMP elements = (x * y) }

variable BMP_X            { X position in the .bmp file or data    }

variable BMP_Y            { Y position in the .bmp file or data    }

BMP_x_size BMP_y_size * BMP_size !


variable bmp-address    { Stores start address of current bmp file             }

variable bmp-address_1  { Stores start address of current bmp file             }

variable bmp-address_2  { Stores start address of current bmp file             }

variable bmp-length   { Length in bytes of current bmp file including header   }

variable bmp-header   { Length in bytes of current bmp header block            }



{ --------------------- Words to create a BMP file in memory ----------------- }

: Get_BMP_Length   ( address -- length )  { Return length of BMP starting at address }
  bmp-address @ 2 + @ 
;


: Get_BMP_X_Size   ( address -- x size )  { Return length of BMP starting at address }
  bmp-address @ 18 + @
;


: Get_BMP_Y_Size   ( address -- x size )  { Return length of BMP starting at address }
  bmp-address @ 22 + @
;


: Reset_BMP_Pixels   { Set all color elements of BMP to zero }
  bmp-address @ 56 + 
  bmp-length @ 55 - 0 fill ;


: Make-Memory-Bmp ( -- address)        { Create a 24 bit (RGB) bitmap in memory              }
  BMP_size @ 3 * 54 + chars allocate   { Allocate required memory 3 x size + header in chars }
  drop bmp-address !

  BMP_size @ 3 * 54 + bmp-length !     { Store file length }
  54                    bmp-header !   { Sore header size  }


  Reset_BMP_Pixels                 { Set BMP pixels to black        }

  { Create BMP header block }

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
 
  BMP_size @ 3 * 54 + pad !        { Store file length in header as 32 bit Dword }
  pad     c@ bmp-address @ 2 + c! 
  pad 1 + c@ bmp-address @ 3 + c! 
  pad 2 + c@ bmp-address @ 4 + c! 
  pad 3 + c@ bmp-address @ 5 + c! 

  BMP_x_Size pad !                 { Store bmp x dimension in header             }
  pad     c@ bmp-address @ 18 + c! 
  pad 1 + c@ bmp-address @ 19 + c! 
  pad 2 + c@ bmp-address @ 20 + c! 
  pad 3 + c@ bmp-address @ 21 + c! 

  BMP_y_Size pad !                 { Store bmp y dimension in header             }
  pad     c@ bmp-address @ 22 + c! 
  pad 1 + c@ bmp-address @ 23 + c! 
  pad 2 + c@ bmp-address @ 24 + c! 
  pad 3 + c@ bmp-address @ 25 + c!
;


: Make-Memory-Bmp_XY ( X Y -- address)  { Create a 24 bit (RGB) bitmap in memory size X by Y  }

  dup BMP_Y ! 
  swap dup BMP_X !
  * BMP_Size !

  BMP_size @ 3 * 54 + chars allocate   { Allocate required memory 3 x size + header in chars }
  drop bmp-address !

  BMP_size @ 3 * 54 + bmp-length !   { Store file length }
  54                  bmp-header !   { Sore header size  }


  Reset_BMP_Pixels                 { Set BMP pixels to black        }

  { Create BMP header block }

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
 
  BMP_size @ 3 * 54 + pad !        { Store file length in header as 32 bit Dword }
  pad     c@ bmp-address @ 2 + c! 
  pad 1 + c@ bmp-address @ 3 + c! 
  pad 2 + c@ bmp-address @ 4 + c! 
  pad 3 + c@ bmp-address @ 5 + c! 

  BMP_X @ pad !                    { Store bmp x dimension in header             }
  pad     c@ bmp-address @ 18 + c! 
  pad 1 + c@ bmp-address @ 19 + c! 
  pad 2 + c@ bmp-address @ 20 + c! 
  pad 3 + c@ bmp-address @ 21 + c! 

  BMP_Y @ pad !                    { Store bmp y dimension in header             }
  pad     c@ bmp-address @ 22 + c! 
  pad 1 + c@ bmp-address @ 23 + c! 
  pad 2 + c@ bmp-address @ 24 + c! 
  pad 3 + c@ bmp-address @ 25 + c!
;


{ ------------------ Word to display BMP using Windows Calls ------------------  }


Function: SetDIBitsToDevice ( a b c d e f g h i j k l -- res )

: MEM-BMP ( addr -- )                 { Prints bmp starting at address to screen }
   [OBJECTS BITMAP MAKES BM OBJECTS]
   BM BMP!
   HWND GetDC ( hDC )
   DUP >R ( hDC ) 1 1 ( x y )         { (x,y) upper right corner of bitmap       }
   BM Width @ BM Height @ 0 0 0
   BM Height @ BM Data
   BM InfoHeader DIB_RGB_COLORS SetDIBitsToDevice DROP
   HWND R> ( hDC ) ReleaseDC DROP ;


: Show-BMP
  bmp-address @ mem-bmp  ;


{ --------------------------- Words to Color BMP Pixels -----------------------------}


: Random_BMP_Red                                      { Set bmp to random red pixels }
  bmp-length @ bmp-header @ 1 + do
  0       bmp-address @ 0 + i + c!
  256 RND bmp-address @ 1 + i + c!
  0       bmp-address @ 2 + i + c!
  3 +loop ;


: Random_BMP_Blue                                     { Set bmp to random blue pixels }
  bmp-length @ bmp-header @ 1 + do
  0       bmp-address @ 0 + i + c!
  0       bmp-address @ 1 + i + c!
  256 RND bmp-address @ 2 + i + c!
  3 +loop ;


: Random_BMP_Green                                    { Set bmp to random green pixels }
  bmp-length @ bmp-header @ 1 + do
  256 RND bmp-address @ 0 + i + c!
  0       bmp-address @ 1 + i + c!
  0       bmp-address @ 2 + i + c!
  3 +loop ;


{ ------------------------ The base window class --------------------------- }

0 VALUE hApp_1

0 VALUE hApp_2

DEFER ClassName_1  :NONAME   Z" Multi_BMP_1" ;   IS ClassName_1

DEFER AppTitle_1 :NONAME   Z"  BMP Window 1" ;   IS AppTitle_1

: ENDAPP_1 ( -- res )
   'MAIN @ [ HERE CODE> ] LITERAL < IF ( not an application yet)
      0 TO hApp_1
   ELSE ( is an application)
      0 PostQuitMessage DROP
   THEN 0 ;


[SWITCH AppMessages_1 DEFWINPROC ( msg -- res ) WM_DESTROY RUNS ENDAPP_1 SWITCH]

:NONAME ( -- res ) MSG LOWORD AppMessages_1 ; 4 CB: APP-WNDPROC_1

: /APP-CLASS_1 ( -- )
      0  CS_OWNDC   OR
         CS_HREDRAW OR
         CS_VREDRAW OR                  \ class style
      APP-WNDPROC_1                     \ wndproc
      0                                 \ class extra
      0                                 \ window extra
      HINST                             \ hinstance
      HINST 101  LoadIcon 
      NULL IDC_ARROW LoadCursor         \
      WHITE_BRUSH GetStockObject        \
      0                                 \ no menu
      ClassName_1                       \ class name
   DefineClass DROP ;


: /APP-WINDOW_1 ( -- hwnd )
   0 TO hApp_1
      0                                 \ extended style
      ClassName_1                       \ window class name
      AppTitle_1                        \ window caption
      WS_OVERLAPPEDWINDOW
      40 40
      BMP_x_size 10 +
      BMP_y_size 30 +                   \ position and size
      0                                 \ parent window handle
      0                                 \ window menu handle
      HINST                             \ program instance handle
      0                                 \ creation parameter
   CreateWindowEx DUP -EXIT
   DUP TO hApp_1
   DUP SW_SHOW ShowWindow DROP
   DUP UpdateWindow DROP ;


:PRUNE   ?PRUNE -EXIT
   hApp_1 IF hApp_1 WM_CLOSE 0 0 SendMessage DROP THEN
   ClassName_1 HINST UnregisterClass DROP ;


: AppStart_1 ( -- hwnd )
   hApp_1 ?EXIT /APP-CLASS_1 /APP-WINDOW_1 ;


{ ---------- Define a menu with the button classes, exit, & about --------- }


100 ENUM M_EXIT
    ENUM M_ABOUT
VALUE M_USED

MENU APP-MENU

   POPUP "&File"
      M_EXIT   MENUITEM "E&xit"
   END-POPUP

   POPUP "&Help"
      M_ABOUT  MENUITEM "&About"
   END-POPUP

END-MENU


{ ------------------------------------ ABOUT box --------------------------- }


: APP-ABOUT ( -- )
   HWND Z" Multi Widow Test"  Z" Bmp Test 1" MB_OK MessageBox DROP ;

: MAKE-MENU ( -- )
   HWND APP-MENU LoadMenuIndirect SetMenu DROP ;


{ ---------------------------------- DEFERS -------------------------------- }

DEFER MakeStatus   ' NOOP      IS MakeStatus
DEFER SizeStatus   ' NOOP      IS SizeStatus
DEFER MakeToolbar  ' NOOP      IS MakeToolbar
DEFER SizeToolbar  ' NOOP      IS SizeToolbar
DEFER MakeMenu     ' MAKE-MENU IS MakeMenu
DEFER CreateMore   ' NOOP      IS CreateMore
DEFER AboutApp     ' APP-ABOUT IS AboutApp


{ -------------------------------------------------------------------------- }


: APP-EXIT ( -- )
   HWND WM_CLOSE 0 0 PostMessage DROP ;

[SWITCH AppCommands DROP ( cmd -- )
   M_EXIT   RUNS APP-EXIT
   M_ABOUT  RUNS AboutApp
SWITCH]

[+SWITCH AppMessages_1 ( -- res )
   WM_SIZE    RUN: SizeStatus SizeToolbar 0 ;
   WM_COMMAND RUN: WPARAM LOWORD AppCommands 0 ;
   WM_CREATE  RUN: MakeMenu MakeStatus MakeToolbar CreateMore 0 ;
   WM_CLOSE   RUN: HWND GetMenu DestroyMenu DROP
                   HWND DestroyWindow DROP 0 ;
SWITCH]

        
{ ------------------------ Windows Output Routines ------------------------- }


: BMP-CREATE ( -- res ) HWND 0 Update_Timer 0 SetTimer DROP  0 ; 


: BMP_Window_Update_1 ( -- res )  HWND bmp-address_1 @ bmp-address ! show-bmp       0 ;


: BMP_Window_Update_2 ( -- res )  HWND bmp-address_2 @ bmp-address ! show-bmp       0 ;


[+SWITCH AppMessages_1
   WM_CREATE  RUNS BMP-CREATE   
   WM_TIMER   RUNS BMP_Window_Update_1
 SWITCH]



{ ---------------------------- Testing ----------------------------------- }


make-memory-bmp                      { Create a BMP in memory to start with }
Random_BMP_Red
bmp-address @ bmp-address_1 !


: Random_BMPs
  begin
  bmp-address_1 @ bmp-address ! Random_BMP_Red
  key?                               { Stop on a keypress }
  until ;


: go 
  appstart_1 drop
  Random_BMPs ;

go

