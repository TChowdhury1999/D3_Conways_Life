
{ ----------------- Text Output Window for Life Development ----------------- }
{                                                                             }
{  Creates a new window and writes a series of dummy variable values          }
{  to it in real time                                                         }
{                                                                             }
{                        Roland A Smith 09/10/2020                            }


10 constant L-Spaces    { Set value of number of leading Spaces for right jst.}

8  constant Char-Pixels { Amount / pixels per text char for right just. outpt.}

variable Test_Var_1     { Dummy variables for test purposes }
variable Test_Var_2
variable Test_Var_3  
variable Test_Var_4   
variable Test_Var_5
variable Test_Var_6
variable Test_Var_7


: Text-Out  ( hdc -- )     { Output formatted text - numbers right justified  }

 {  DUP Font-Handle @ SelectObject drop  \ set font type here }

   DUP ( hdc)  10  20 S" Title 001       "      TextOut DROP  { Write titles to window }
   DUP ( hdc)  140 20 S"                 "      TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_1 @ (.) 
               swap drop - Char-Pixels *
               100 + 20 Test_Var_1 @ (.)        TextOut DROP

   DUP ( hdc)  10  40 S" Title 002       "      TextOut DROP
   DUP ( hdc)  140 40 S"                 "      TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_2 @ (.)
               swap drop - Char-Pixels *
               100 + 40 Test_Var_2 @ (.)        TextOut DROP

   DUP ( hdc)  10  60 S" Title 003       "      TextOut DROP
   DUP ( hdc)  140 60 S"                 "      TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_3 @   (.)
               swap drop - Char-Pixels *
               100 + 60 Test_Var_3 @   (.)      TextOut DROP
 
   DUP ( hdc)  10  80 S" Title 004       "      TextOut DROP
   DUP ( hdc)  140 80 S"                 "      TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_4 @    (.)
               swap drop - Char-Pixels *
               100 + 80 Test_Var_4 @    (.)     TextOut DROP

   DUP ( hdc)  10 100 S" Title 005       "      TextOut DROP
   DUP ( hdc)  140 100 S"                "      TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_5 @  (.)
               swap drop - Char-Pixels *
               100 + 100 Test_Var_5 @ (.)       TextOut DROP   

   DUP ( hdc)  10 120 S" Title 006       "      TextOut DROP
   DUP ( hdc)  140 120 S"                 "     TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_6 @   (.)
               swap drop - Char-Pixels *
               100 + 120 Test_Var_6 @  (.)      TextOut DROP

   DUP ( hdc)  10 140 S" Title 007       "      TextOut DROP
   DUP ( hdc)  140 140 S"                 "     TextOut DROP
   DUP ( hdc)  L-Spaces Test_Var_7 @   (.)  
               swap drop - Char-Pixels *
               100 + 140 Test_Var_7 @  (.)      TextOut DROP 
   DROP
   ;



0 VALUE hAPP-Text                 { Handle for the Text Window                }


CREATE CLASSNAME ,Z" Text-Output" { Classname                                 }


[SWITCH MESSAGE-HANDLER DEFWINPROC ( -- res )
   ( no behavior yet)
SWITCH]


:NONAME ( -- res )
   MSG LOWORD MESSAGE-HANDLER ;  4 CB: APPLICATION-CALLBACK


:PRUNE   ?PRUNE -EXIT
   hAPP-Text IF hAPP-Text WM_CLOSE 0 0 SendMessage DROP THEN
   CLASSNAME HINST UnregisterClass DROP ;


{ --------------------------- Register the class ---------------------------- }


: REGISTER-CLASS ( -- )
   CLASSNAME APPLICATION-CALLBACK DefaultClass DROP ;


{ ------------------------ Create and show the window ----------------------- }

: CREATE-TEXT-WINDOW ( -- handle )
      0                                 \ extended style
      CLASSNAME                         \ window class name
      Z" Laser Data"                    \ window caption
      WS_OVERLAPPEDWINDOW               \ window style
      40 40 250 220                     \ static initial position and size
      0                                 \ parent window handle
      0                                 \ window menu handle
      HINST                             \ program instance handle
      0                                 \ creation parameter
   CreateWindowEx ;


: START-TEXT-WINDOW ( -- flag )
   REGISTER-CLASS CREATE-TEXT-WINDOW DUP IF
      DUP SW_NORMAL ShowWindow DROP
      DUP UpdateWindow DROP
      TO hAPP-Text
   THEN ;


{ ---------------  Encapsulate the functionality of the program ------------- }


50 Constant Text-Update-Timer   { Sets Text windows update rate     }


: TEXT-CREATE ( -- res ) HWND 0 Text-Update-Timer 0 SetTimer DROP  0 ; 


: REFRESH ( -- )
   HWND 0 0 InvalidateRect DROP ;


: REPAINT ( -- res )
   HWND PAD BeginPaint ( hdc)
   HWND HERE GetClientRect DROP
   ( hdc)  Text-Out
   HWND PAD EndPaint DROP  0 ;


[+SWITCH MESSAGE-HANDLER ( -- res )
   WM_CREATE RUNS TEXT-CREATE
   WM_TIMER  RUNS REFRESH
   WM_PAINT  RUNS REPAINT
   WM_CLOSE  RUN: HWND DestroyWindow DROP 0 TO hAPP-Text  0 ;
   WM_DESTROY RUN: 0 'MAIN @ ?EXIT PostQuitMessage ;
SWITCH]


  START-TEXT-WINDOW

: Text-Test             { Simple time limited test routine }
  100 1 do
  I 1 *  Test_Var_1 !
  I 2 *  Test_Var_2 !
  I 3 *  Test_Var_3 !
  I 4 *  Test_Var_4 ! 
  I 5 *  Test_Var_5 !
  I 6 *  Test_Var_6 !
  I 7 *  Test_Var_7 !
  40 ms
  loop
 ;


  Text-Test

