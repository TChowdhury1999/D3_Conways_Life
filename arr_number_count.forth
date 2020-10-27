{ Created by Tanjim Chowdhury
  19/10/2020         }



variable zeroo
variable one
variable two
variable three
variable four
variable five
variable six
variable seven
variable eight

0 zeroo !
0 one !
0 two ! 
0 three !
0 four ! 
0 five !
0 six !
0 seven !
0 eight !

{ requires address and n on stack }
: arr_number_count cr dup square 0 do                                   { address n still there} 
	over i + c@ 														{ address n still there}
	case
		0 of zeroo dup @ 1+ swap ! endof
		1 of one dup @ 1+ swap ! endof
		2 of two dup @ 1+ swap ! endof
		3 of three dup @ 1+ swap ! endof
		4 of four dup @ 1+ swap ! endof
		5 of five dup @ 1+ swap ! endof
		6 of six dup @ 1+ swap ! endof
		7 of seven dup @ 1+ swap ! endof
		8 of eight dup @ 1+ swap ! endof

	endcase loop ;

	

: print_percentages cr
	zeroo @ 10000 * over square / . ." x 10^-2 %" cr
	one @ 10000 * over square / . ." x 10^-2 %" cr
	two @ 10000 * over square / . ." x 10^-2 %" cr
	three @ 10000 * over square / . ." x 10^-2 %" cr
	four @ 10000 * over square / . ." x 10^-2 %" cr
	five @ 10000 * over square / . ." x 10^-2 %" cr
	six  @ 10000 * over square / . ." x 10^-2 %" cr
	seven @ 10000 * over square / . ." x 10^-2 %" cr
	eight @ 10000 * over square / . ." x 10^-2 %" ;
			
