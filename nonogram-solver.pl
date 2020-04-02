:- use_module(library(clpfd)).

nonogram(PuzzelGrootte, HorizontaleClues, VerticaleClues,Rijen):-
    valide_rijen(PuzzelGrootte, Rijen, HorizontaleClues),
    transpose(Rijen, Kolommen),
    valide_rijen(PuzzelGrootte, Kolommen, VerticaleClues).

valide_rijen(PuzzelGrootte, Rijen, Clues) :-
    maplist(valide_rij(PuzzelGrootte), Rijen, Clues).

valide_rij(PuzzelGrootte, Rij, Clues) :-
    length(Rij, PuzzelGrootte),
    maplist(valide_element, Rij),
    splits_reeksen(Rij, Reeksen),
    maplist(valide_reeks, Reeksen, Clues).

valide_element(Element) :-
    Element is 1 | Element is 0.

gevuld_vakje(Vakje) :-
    Vakje is 1.

valide_reeks(Reeks, Clue):-
    length(Reeks, Clue),
    maplist(gevuld_vakje, Reeks).

splits_reeksen(Rij, Reeksen) :-
    split(Rij, 0, ReeksenMetLegen),
    delete(ReeksenMetLegen, [], Reeksen).


% Uit de swi-prolog list_util pack
split([], _, [[]]) :-
    !.  % optimization
split([Div|T], Div, [[]|Rest]) :-
    split(T, Div, Rest),  % implies: dif(Rest, [])
    !.  % optimization
split([H|T], Div, [[H|First]|Rest]) :-
    dif(H, Div),
    split(T, Div, [First|Rest]).
