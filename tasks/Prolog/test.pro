myTrue.
myFalse.
parent('Adam', 'Avel').
parent('Eve', 'Avel').
parent('Adam', 'Kain').
parent('Kain', 'Mafusail').
grandparent(X, Y) :- parent(X, Z),
                    parent(Z, Y).
grandparent(X) :- grandparent(Y, X),
                  writeln(Y).
% [X|XS]
% [X,Y,Z|XS]

last([], _) :- !, fail.
last([X], X).
last([_|XS], X) :- last(XS, X).
last(L):-last(L, X), !, writeln(X).

%% fact(0, 1) :- !.
%% fact(N, X) :- N1 is N - 1,
%%               fact(N1, X1), X is N * X1.

% а теперь факториал с хвостовой рекурсией
% N задано, R - результат, I - счётчик, P - аккумулятор
factorial(N, N, R, R) :- !.
factorial(N, I, R, P) :- I1 is I + 1, P1 is I1 * P,
                         factorial(N, I1, R, P1).
factorial(N, X) :- factorial(N, 0, X, 1).