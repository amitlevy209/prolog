/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).
edge(a,b).
edge(a,c).
edge(c,b).
edge(c,a).


% Signature: path(Node1, Node2, Path)/3
% Purpose: Path is a path, denoted by a list of nodes, from Node1 to Node2.
path(X,Y,[X,Y]):- edge(X,Y).
path(X,Y,[X|Z]):- edge(X,T),path(T,Y,Z).

% Signature: cycle(Node, Cycle)/2
% Purpose: Cycle is a cyclic path, denoted a list of nodes, from Node1 to Node1.
cycle(Source,[Source,X,Source]):- edge(Source,X),edge(X,Source).
cycle(source,[X|Cycle]):-edge(source,X),path(X,source,Cycle).

% Signature: reverse(Graph1,Graph2)/2
% Purpose: The edges in Graph1 are reversed in Graph2
reverse([],[]).
reverse([[X, Y] | G1], [[Y, X] | G2]) :- reverse(G1, G2).

natural_number(zero).
natural_number(s(X)):- natural_number(X).


% Signature: degree(Node, Graph, Degree)/3
% Purpose: Degree is the degree of node Node, denoted by a Church number (as defined in class)
degree(_,[],zero).
degree(Node,[[Node,_]|G],s(D)):- degree(Node,G,D).
degree(Node, [[_, Node] | Rest], Degree) :- degree(Node, Rest, Degree).
degree(Node,[[_,_]|G],D):- degree(Node,G,D).
       
       