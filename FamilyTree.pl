parent(X, Y):- child(Y, X).
father(X, Y):- man(X), parent(X, Y).

mother(X, Y):- woman(X), parent(X, Y).

age_of(X,Z):-  year_born(X,Y), Z is(2020-Y).

sibling(X,Y):- child(X,Z), child(Y,Z),not(X=Y).

grandparent(X,Z):- parent(X,Y), parent(Y,Z).

cousin(X,Y):-grandparent(Z,X), grandparent(Z,Y),not(X=Y), not(sibling(X,Y)).

nth_cousin(X,Y,1):- parent(P1,X), parent(P2,Y), sibling(P1,P2), not(X = Y).
nth_cousin(X,Y,Np1):-
     N is Np1-1, parent(P1,X), parent(P2,Y), nth_cousin(P1,P2, N).

parent_recursive(Z,Y,1):-
    parent(Z,Y).

parent_recursive(Z,Y, P1):-
    P is P1-1,
    parent(Z,W), parent_recursive(W,Y,P).

nth_kremoved_cousin(X,Y,N,K):-
    nth_cousin(X,Z,N),
    parent_recursive(Y,Z, K).


older(X,Y) :-  age_of(X,A), age_of(Y,B), (A > B).

age_sort(L,M) :- permutation(L,M) , ages(M).

ages([]). /*form empty set*/

ages([_|[]]).
ages([H, H1|T]) :- older(H, H1), ages([H1|T]).

kth_child(P,C,K) :- setof(C, child(C,P),L), age_sort(L,M), nth0(K, M, C).
