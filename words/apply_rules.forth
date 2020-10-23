{ Created by Tanjim Chowdhury
  20/10/2020         }


{ takes val from 0 to 8
  returns 0 if cell will always die
  returns 1 if cell will always be alive
  returns 2 if no effect }
  
: neighbour_rules cr                                   							
	case
		0 of 0 endof
		1 of 0 endof
		2 of 1 endof
		3 of 2 endof
		4 of 0 endof
		5 of 0 endof
		6 of 0 endof
		7 of 0 endof
		8 of 0 endof

	endcase ;

{ requires input of state (0 for dead, 1 for alive) then number of neighbours
  returns 0 if cell will be dead
  returns 1 if cell will be alive }

: apply_rules cr neighbour_rules
	case
		0 of 0 endof
		1 of 1 endof
		2 of dup endof
	endcase nip ;
	
