% notes
inc(Y,Z) :- Z is Y+1.
inc_2(Y,Z) :- Z is Y+1.

%%%%%%%%%%%% fall 15 %%%%%%%%%%%

/*
1. Suppose this definition of predicate p is found in Prolog’s database:
p(X, X).
Determine and explain the output that would appear upon entering this query:
?- p(L, [a|L]).
a. First assume that the “occurs check” is implemented in this version of Prolog.
b. Next assume that the “occurs check” is not implemented in this version of Prolog.
c. Why do most versions of Prolog usually omit performing the “occurs check”?
*/

/*
2. Explain why in Prolog the built-in “not” predicate and the cut (“!”) operator each contradict the
idea of pure logic programming. Also write Prolog coding examples that illustrate the proper
usage of the not predicate and the cut operator.
*/

/*
3. Suppose a Prolog database defines relations of the form male(X), female(X), sibling(X, Y),
spouse(X, Y), and parent(X, Y), which means that X is a parent of Y. Write these Prolog
predicates:
• nephew(X, Y), which means that X is a nephew of Y.
Note: your nephew is your brother’s son, sister’s son, or spouse’s nephew.
• niece(X, Y), which means that X is a niece of Y.
Note: your niece is your brother’s daughter, sister’s daughter, or spouse’s niece.
• uncle(X, Y), which means that X is an uncle of Y.
Note: your uncle is your father’s brother, mother’s brother, or aunt’s husband.
• aunt(X, Y), which means that X is an aunt of Y.
Note: your aunt is your father’s sister, mother’s sister, or uncle’s wife.
*/
nephew(X,Y) :- male(X), parent(Z,X), sibling(Z,Y).
niece(X,Y) :- female(X), parent(Z,X), sibling(Z,Y).
%uncle(X,Y) :- male(X),
%aunt(X,Y) :- female(X),

/*
4. Suppose a Prolog database contains only facts of the form parent(x, y), which means that X is a
parent of Y. Write the Prolog predicate cognate(X, Y), which means that X is blood-related to Y.
*/
cognate(X, X).
cognate(X, Y) :- parent(Z,X), cognate(Z,Y).
cognate(X, Y) :- parent(Z,Y), cognate(Z,X).

/*
5. Write this predicate using Prolog: function(N, Z) succeeds when Z is the dot product of lists
[1,2,…,N–1,N] and [N,N–1,…,2,1]. Examples:
function(5, Z) succeeds when Z = 1*5 + 2*4 + 3*3 + 4*2 + 5*1 = 35.
function(6, Z) succeeds when Z = 1*6 + 2*5 + 3*4 + 4*3 + 5*2 + 6*1 = 56
*/
isDot(N,F) :- isDotHelper(N,1,0,F).
isDotHelper(0,_,F,F).
isDotHelper(X,Y,Z,F) :- X>0, A is X-1, B is Y+1, C is (X*Y)+Z, isDotHelper(A,B,C,F).

/*
6. You are given this Prolog database. Assume that append is defined in the usual way.
predicate([ ], [ ]).
predicate([H|T], L) :- predicate(H, X), predicate(T, Y), append(X, Y, L).
predicate(Z, [Z]).
Write all the solutions to Q for this Prolog query:
?- predicate([[ ], 0], Q).

predicate([], X), predicate([0], Y), append(X, Y, L).
X=[] or X=[[]]
Y=predicate([0], Y)

predicate([0], Y)
predicate(0,X), pred([],Y), append()
pred(0,X) = [0]
pred([],Y) = [] or [[]]

Q = [[[ ],0]]
Q = [] + [0] + [] = [0]
Q = [] + [0] + [[]] = [0, []]
Q = [[]] + [0] + [] = [[] ,0]
Q = [[]] + [0] + [[]] = [[], 0 ,[]]

[[0]]
[[],[0]]
*/

/*
7. Write these two predicates using Prolog: power and log. power(M, N, Q) succeeds when Q
is the result value obtained by raising M to the power N. log(M, Q, N) succeeds when N is
the smallest non-negative integer such that raising M to the power N yields at least Q.
Examples: power(2, 3, Q) yields Q=8. power(2, 4, Q) yields Q=16.
log(2, 8, N) yields N=3. log(2, 16, N) yields N=4. log(2, 10, N) yields N=4.
*/
power(_,0,1).
power(M,N,Q) :- N>0, X is N-1, power(M,X,Y), Q is M*Y.


%%%%%%%%%%%% spring 15 %%%%%%%%%%%%%

/*
1. Write this predicate using Prolog: inner(X,Y,Z) succeeds when Z is the inner product of
lists X and Y with respect to binary operations + and *. This kind of inner product is also
called a dot product. You may assume that lists X and Y have the same length. Example:
inner([1,2,3], [4,5,6], 32), because 1*4+2*5+3*6 = 32.
*/

inner([],[],0).
inner([A|B],[C|D],Z) :- inner(B,D,Y), Z is A*C + Y.

/*
2. Write this predicate using Prolog: outer(X,Y,Z) succeeds when Z is the outer product of lists X
and Y with respect to binary operation *. This kind of outer product is also called a
multiplication table. Here Z is a list with same length as X, each of whose elements is a sublist
with same length as Y. The kth element of the j
th sublist is obtained by multiplying the j
th
element of X and the kth element of Y. Example: outer([1,2,3], [4,5,6,7],
[[4,5,6,7],[8,10,12,14],[12,15,18,21]]).
*/

outer([],_,[]).
outer([A|B],L,[X|Y]) :- outerhelper(A, L, X), outer(B, L, Y).
outerhelper(_,[],[]).
outerhelper(Q,[A|B],[X|Y]) :- X is Q*A, outerhelper(Q,B,Y).

/*
3. Write this predicate using Prolog: scan(L, Q) succeeds if L and Q are lists of numbers, and Q is
obtained by summing each possible prefix of L. Example: scan([2,3,5,7,11,13], Q) succeeds
with Q = [0,2,5,10,17,28,41].
*/

%%%%%%%%%%%%%%%%% spring 17 %%%%%%%%%%%%%

/*
1. Given this Prolog database:
a(X) :- write(X), nl.
b(_).
b(X) :- a(X), fail.

%q :- member(X, [2,3]), a(try(x, X)), b(nix(x, X)), member(Y, [4,3]), a(try(y, Y)), b(nix(y, Y)), X > Y.

Write the output exactly as it would appear upon asking the following query:
*/

/*
2. twist(L, R) reverses the top level of list L, and recursively twists every nested sublist. Example:
twist([1,2,[a,b],[3,[4,c],d],[[e,f],[5,6]],g,7], R) returns R = [7,g,[[6,5],[f,e]],[d,[c,4],3],[b,a],2,1].
*/

/*
3. mysqrt(N, R) returns the truncated square root of non-negative integer N. Do not use the
built-in “sqrt” or ** functions. Example: mysqrt(31, R) returns R = 5. For full credit, your
function should be efficient. Hint: Use a helper predicate that does binary search in the
range 0 to N. For half credit, use a less efficient linear search.
*/

/*
4. factorize(N, R) returns a list of all the prime factors whose product yields the positive integer N.
Examples: factorize(360, R) returns R = [2,2,2,3,3,5], and factorize(361, R) return R = [19,19].
For full credit, your function should be efficient. Hint: Use a helper predicate that checks
possible factors in the range 2 to √N.
*/

/*
5. countall(L, R) counts the total number of values within all nested levels of L that are not lists.
Example: countall([a,b,[c,[ ],[d]],[[e,[f],[[g]],[ ]],h]], R) returns R = 8.
*/

/*
6. powerset(S, R) takes a set S represented as a list, and returns a list with all the subsets of S. Your
predicate may arrange each list in any order, because the order of elements within a set does
not matter. Example: powerset([a,b,c], R) returns R = [[a,b,c], [a,b], [a,c], [a], [b,c], [b], [c], [ ]].
*/

/*
7. level(N, L, R) returns a list of all the non-list values that are nested N levels deep within L.
Examples: If L = [a, [6, b], [ ], 7, [[c], [8]], [d, 9], [[ ]], e] then:
level(0, L, R) returns R = [ ].
level(1, L, R) returns R = [a, 7, e].
level(2, L, R) returns R = [6, b, d, 9].
level(3, L, R) returns R = [c, 8].
level(4, L, R) returns R = [ ].
*/

/*
8. distinct(L) succeeds iff all the values in list L are different from each other, and disjoint(L1, L2)
succeeds iff all the values in list L1 are different from all the values in list L2. Examples:
distinct([a,b,c,d,e]) returns true, and distinct([a,b,c,d,b,e]) returns false.
disjoint([a,b,a,c], [d,e,f,e]) returns true, and disjoint([a,b,c,d], [e,c,f,g]) returns false.
*/

/*
9. Suppose a Prolog database defines family relations of the form sibling(X, Y), spouse(X, Y),
and parent(X, Y), which means that X is a parent of Y. Define these two new predicates:
parent_in_law(X, Y) and sibling_in_law(X, Y).
*/

/*
10. Suppose a Prolog database defines family relations of the form sibling(X, Y), spouse(X, Y),
and parent(X, Y), which means that X is a parent of Y. Define these three new predicates:
step_parent(X, Y), half_sibling(X, Y), and step_sibling(X, Y).
*/

%%%%%%%%%%%%%%%%% spring 18 %%%%%%%%%%%%%%%

/*
+, -, *, div, mod, max, min, is, =, \=, =:=, =\=, <, =<, >, >=, pattern matching, atom, number, atomic,
lists and nested lists, append, reverse, last, member, length, the cut (!), not (or \+), fail, write, nl.
*/

/*
1. fun(L, R) computes the sum of the fourth powers of all the odd positive numbers in the list L,
and returns the result in R. Example: the query fun([2,3,-2,6,5,-3], R) yields R = 34 + 54 = 706.
*/

%s18q1([], 0).
%s18q1([H|T],R) :- H>0, 1 is mod(H,2), s18q1(T,X), R is X+H*H*H*H, !.
%s18q1([_|T],R) :- s18q1(T,R).
%s18q1([2,3,-2,6,5,-3],R).

s18q1([],0).
s18q1([H|T],R) :- H>0, 1 is mod(H,2), s18q1(T,X), R is X + H*H*H*H.
s18q1([_|T],R) :- s18q1(T,R).
%s18q1([2,3,-2,6,5,-3],R).

/*
2. evalpoly(P, V, R) takes a polynomial with coefficients given in list P, and evaluates it at V. Example:
The list [2,3,5,6,8,9] denotes polynomial 2 + 3x + 5x2 + 6x3 + 8x4 + 9x5, therefore the query
evalpoly([2,3,5,6,8,9],10,R) yields R = 2 + 3*10 + 5*102 + 6*103 + 8*104 + 9*105 = 986532.
*/

%evalpoly([],_,0).
%evalpoly([H|T], X, R) :- evalpoly(T,X,A), R is H+X*A.

evalpoly([],_,0).
evalpoly([H|T], X, R) :- length(T,L), evalpoly(T,X,A), R is A + H*(X**(6 - (L + 1))).
%evalpoly([2,3,5,6,8,9],10,R)

/*
3. transpose(M, R) constructs the transpose of matrix M, which is represented as a list of lists,
and returns the result in R. Example: the query
transpose([[1,2,3],[4,5,6],[7,8,9],[10,11,12]],R) yields R = [[1,4,7,10],[2,5,8,11],[3,6,9,12]].
*/

/*
4. In a game of nim, two players alternate turns, and each turn consists of removing stones from
a pile. Each player may remove either 1 stone or n/2 stones, where n is the current number
of stones in the pile. The winner is the player who removes the last remaining stone.
win(X, Y) succeeds iff there is a winning strategy for the current player in a game of nim such
that the pile currently has X stones, and if so, it returns the number of stones that the current
player should remove in Y. The table below summarizes some examples of the query win(X,Y):
X 1 2 3 4 5 6 7 8 9 10
Y 1 f 1 2 f 1 f 1 4 5
*/

/*
5. CS 403: Two people are kth cousins if each has an ancestor k generations back which are
siblings. For example, 1st cousins are children of siblings. Suppose a Prolog database
defines only family relations of the form parent(X,Y) which means that X is a parent of Y.
Write the new predicate cousin(K,X,Y) which means that X and Y are Kth cousins.
*/

/*
6. CS 403: evaluate(X, R) evaluates an expression X that will only include operations add, sub,
mul, neg, and integer values, and returns the result in R. Example: the query
evaluate(mul(add(3,4),sub(8,neg(2))),R) yields R = (3+4)*(8-(-2)) = 70.
*/

%%%%%%%%%%%%%%% fall 2018 %%%%%%%%%%%%%

%last and init

%antitranspose

%applyleft

%first atom last atom

%maxdepth

%triples [0,1] [2,3] [4,5] returns [(0,2,4),(0,2,5),(0,3,4),(0,3,5),(1,2,4),(1,2,5),(1,3,4),(1,3,5)].

%pythagoras 15 returns [(3,4,5),(5,12,13),(6,8,10),(9,12,15)]. 

/*
m1 = [[1,2,3],[4,5,6],[7,8,9]] then:
combine (+) (*) m1 returns (1*2*3) + (4*5*6) + (7*8*9) = 630.
combine (*) (+) m1 returns (1+2+3) * (4+5+6) * (7+8+9) = 2160.
*/

/*
mix sum product [[1,2,3],[4,5,6],[7,8,9]] returns (1+4+7) * (2+5+8) * (3+6+9) = 3240.
mix product sum [[1,2,3],[4,5,6],[7,8,9]] returns (1*4*7) + (2*5*8) + (3*6*9) = 270.
*/

% diffproduct [7, 13, 3] returns -240, because (7-13) * (7-3) * (13-3) = -240

/*
take 6 (harmonic 1) = [1/1, 1/1 + 1/2, 1/1 + 1/2 + 1/3,
1/1 + 1/2 + 1/3 + 1/4, 1/1 + 1/2 + 1/3 + 1/4 + 1/5, 1/1 + 1/2 + 1/3 + 1/4 + 1/5 + 1/6] =
[1.0, 1.5, 1.833333, 2.083333, 2.283333, 2.45]
*/

%count nodes of three

%iscomplete returns True if every leaf of the tree is at the same depth, and otherwise it returns False