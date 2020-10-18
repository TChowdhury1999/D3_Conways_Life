    
{ ----------------- Basic File I/O in SwiftForth - R A Smith 2004 ------------------- }


{ NOTES  Forth uses an integer number called a "file handle" to identify any file you }
{        create or open for file I/O operations.  Before we start to use a file, we   }
{        need to create a variable to hold the file handle so that we can referr to   }
{        it in later read and write operations.  File operations will genarally       }
{        return a true / false flag depending on whether the operation worked or not  }
{        hence all the "drop" commands in the section below.                          }
{                                                                                     }
{        File Paths - You need to use a complete path to the file when creating or    }
{        opening a file.  If you dont use  a path the file will be assumed to be in   }
{        SwiftForth\Bin directory.                                                    }




variable test-file-id                             { Create Variable to hold file id handle }


: make-test-file                                  { Create a test file to read / write to  }
  s" C:\Users\Tanjim\Desktop\Forth\files\test.dat" r/w create-file drop  { Create the file                        } 
  test-file-id !                                  { Store file handle for later use        }
;

 
: open-test-file                                  { Open the file for read/write access    }
  s" C:\Users\Tanjim\Desktop\Forth\files\test.dat" r/w open-file drop    { Not needed if we have just created     }
  test-file-id !                                  { file.                                  }
;


: close-test-file                                 { Close the file pointed to by the file  }
  test-file-id @                                  { handle.                                }
  close-file drop
; 


: test-file-size                                  { Leave size of file on top of stack as  }
  test-file-id @                                  { a double prescision integer if the     }
  file-size drop                                  { file is open.                          }
;


: write-file-header 
  s"   1st Line of header " test-file-id @ write-line drop { Writes single lines of text to a file }
  s"   2nd Line of header " test-file-id @ write-line drop { terminating each line with a LF/CR.   }
  s"   3rd Line of header " test-file-id @ write-line drop { The file must be open for R/W access  }
  s"                      " test-file-id @ write-line drop { first.                                }
 ;


: write-file-data-1                                        { Write a series of integer numbers to a }
  1 (.) test-file-id @ write-line drop                     { file as ASCII characters.  We use the  }
  2 (.) test-file-id @ write-line drop                     { Forth command (.) to convert numbers   }
  3 (.) test-file-id @ write-line drop                     { on the stack into counted ASCII strings}
;


: write-file-data-2                                        { Write a series of integer numbers to a }               
  100 1 do                                                 { file as ASCII characters from inside a }
  i 20 * (.) test-file-id @ write-line drop                { looped structure.  File must be open   }
  loop                                                     { for R/W access first.                  }
  ;

: Write-file-data-3                                        { Write a series of pairs of integer     }
  20 1 do                                                  { numbers to an open file.               }
  i (.)     test-file-id @ write-file drop
  s"  "     test-file-id @ write-file drop
  i 2 * (.) test-file-id @ write-line drop
  loop
;
  
: Write-blank-data                                         { Write an empty line to the file       }
  s"  " test-file-id @ write-line drop
;



{ --------------- Now lets put all of this together to create, write to and close a file ---------- }             



: go
  make-test-file
  test-file-size cr cr ." File Start Size = " d.
  write-file-header
  write-file-data-1
  Write-blank-data
  write-file-data-2
  Write-blank-data
  Write-file-data-3
  Write-blank-data
  test-file-size cr cr ." File End Size =   " d. cr
  close-test-file
;



