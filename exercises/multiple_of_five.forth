: multiple_of_five
	cr dup
	5 mod 0=
		if ." The number ". ." is a multiple of five "
			else ." The number ". ." is not a multiple of five "
	then cr ;