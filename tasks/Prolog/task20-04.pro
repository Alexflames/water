jIter(N, N, _, Ans, Ans) :- !.
jIter(J, N, I, Slag, Ans) :- SlagN is Slag + (J / I) - I, J1 is J + 1
                           , jIter(J1, N, I, SlagN, Ans).

% Использовано условие. Если N меньше I, то переход на случай их равенства, 
% то есть вывод результата (изначально равен 1.0)
% оно нужно для того, чтобы программа корректно работала для случаев, когда
% N меньше i 
iIter(N, N, Rez) :- writeln(Rez), !.
iIter(I, N, Rez) :- 
  ( N < I -> iIter(N, N, Rez)
  ; IN is N + 1, Slag is 0, jIter(-5, IN, I, Slag, Ans)
  , RezN is Rez * Ans, I1 is I + 1, iIter(I1, N, RezN) ).

% Так как итерация при i = N должна выполняться, просто увеличим N на 1.
y(N) :- N1 is N + 1, iIter(4, N1, 1.0).

?- y(-10).
?- y(-2).
?- y(0).
?- y(2).
?- y(3).
?- y(4).
?- y(5).
?- y(6).