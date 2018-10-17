repeat(_, [], []).
repeat([], _, []).
repeat([_H1 | L1], [0 | L2], Res) :- repeat(L1, L2, Res).
repeat([H1 | L1], [H2 | L2], [H1 | Res]) :- 
  H2M1 is H2 - 1, repeat([H1 | L1], [H2M1 | L2], Res).

repeat(X, Y) :- repeat(X, Y, Res), writeln(Res).

?- repeat([1, 2, 3], [4, 0, 3]).
?- repeat([1, 2, 3, 9], [4, 0, 3]).
?- repeat([1, 2, 3, 9], [4, 0, 3, 2, 7]).
?- repeat([1, 2, 3, 9], []).
?- repeat([], [4, 0, 3]).
?- repeat([], []).