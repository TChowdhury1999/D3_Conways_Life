{ Created by Tanjim Chowdhury
  20/10/2020         }


{ takes val from 0 to 8
  returns 0 if cell will always die
  returns 1 if cell will always be alive
  returns 2 if no effect }
  
: neighbour_rules                                  							{ gets value input and outputs depending on case}
	case																	{ made in this form to easily change rules		}
		0 of 0 endof
		1 of 0 endof
		2 of 2 endof														{ if input is 2, output is 2			}
		3 of 1 endof														{ if input is 3, output is 1			}
		4 of 0 endof														{ if input is any other value, output 0	}
		5 of 0 endof
		6 of 0 endof
		7 of 0 endof
		8 of 0 endof

	endcase ;

{ requires input of state (0 for dead, 1 for alive) then number of neighbours
  returns 0 if cell will be dead
  returns 1 if cell will be alive }

: apply_rules neighbour_rules												{ applies the classic Conways Life Rules}
	case
		0 of 0 endof
		1 of 1 endof
		2 of dup endof
	endcase nip ;
	
