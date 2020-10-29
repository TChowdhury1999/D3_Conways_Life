{ Made by: Tanjim Chowdhury
  23/10/2020               }
  
{ Calculates life_array_2 using existing words then copies life_array_2 into life_array_1
  Requires variables life_array_1, life_array_2 and n
  Requires files array_words, make_neighbours_array, apply_rules and make_life_array_2}
  

: next_gen															{ use for gen>2 so you do not need to }
  fill_n_array														{ make the neighbour array and the 2nd}
  fill_life_array_2													{ life array each iteration           }
;

: copy_array_2_to_1
  life_array_2 @ life_array_1 @ n @ square move						{ copy life_array_2 to life_array_1   }
;

: copy_array_1_to_3
  life_array_1 @ life_array_3 @ n @ square move						{ copy life_array_2 to life_array_1   }
;

: show_l_array														{ word that shows life array 1 on console}
  life_array_2 @ n @ show_array drop drop
;

: next_gen_show														{ same as next_gen but also shows the }
  next_gen show_l_array												{ new life array on console           }
  drop drop
;
