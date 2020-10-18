Code created by Imperial College to be used as guidance for the experiment.
NOT BY ME

=================================================================================================================================================================================




A few examples of how to output text data in real time, write data to disk in an ASCII format and display grahical and numerical data on screen to help you visualise large data arrays in the D3 Conway’s Life experiment.


Text Output Methods

Method 1.

The simplest method is to simply write numerical or string output to the Forth console using standard print operations such as "." .


Method 2.

Text_Output_Window_V1.f

This file creates a new window and then writes dummy numerical data to it in real time.  It can run in parallel with a graphics window.  


File IO

Test_File_IO_Tools.f

Some examples of how to create and write ASCII data to a file on disk, e.g to output statistical data.


Graphics output methods for SwifForth

Method 1.

Graphics_V1_BMP_in_Console.f

Repetitively creates a bitmap image file (.bmp) in memory and writes this to the Forth console window.  A little clunky as this overwrites the window, covering up text output, but has the advantage of not needing some OS specific code to create and communicate with the new window.  Here the .bmp is updated with 50/50 random “dead” and “alive” cells as a stand in for the Conway’s Life simulation.  A down side of this method is that by default, individual cells are only 1 pixel wide, and this can be hard to visualise.


Method 2.

Graphics_V2_squares_in_Window.f

Creates a new window and then repetitively writes random “dead” and “alive” cells to the widow by drawing filled boxes using a set of Windows graphics commands.  A bit slow and clunky, but has the advantage that it is relatively easy to change the size of the boxes, making it easier to visualise an individual cell.


Method 3.

Graphics_V3_BMP_in_Window.f

Creates a new window and repetitively creates a bitmap image file (.bmp) in memory and writes this to the new window.  More OS specific code is needed to create and talk to the window, but the Forth console remains available for simultaneous text output.  Here the .bmp is updated with 50/50 random “dead” and “alive” cells as a stand in for the Conway’s Life simulation.  A down side of this method is that by default, individual cells are only 1 pixel wide, and this can be hard to visualise.  However, once you understand the method you could “paint” regions of colour larger than 1 pixel in the .bmp file. 


Method 4.

Graphics_V4_Two_BMPs_in_Windows.f

Creates a new window and repetitively creates multiple bitmap image files in memory and writes them to the new windows.  More OS specific code is needed to create and talk to the windows, but several views of a data set can be shown at the same time and the Forth console remains available for simultaneous text output.  Here the .bmp images are updated with 50/50 random “dead” and “alive” cells as a stand in for the Conway’s Life simulation.  A down side of this method is that by default, individual cells are only 1 pixel wide, and this can be hard to visualise.  However, once you understand the method you could “paint” regions of colour larger than 1 pixel in the .bmp file or make multiple additional windows.

