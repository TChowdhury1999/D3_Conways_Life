{ n make_array ---> allocates n^2 amount of data and initialises with 0s 
  requires square word }
: make_array square dup allocate drop dup rot 0 fill ;