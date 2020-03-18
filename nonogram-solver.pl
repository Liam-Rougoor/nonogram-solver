valide_rij(Rij, Clues) :-
    is_list(Rij), 
    is_list(Clues),
    maplist(valide_element, Rij),
    splits_reeksen(Rij, Reeksen),
    maplist(valide_reeks, Reeksen, Clues).

valide_element(Element) :-
    Element in 0..1.

valide_reeks(Reeks, Clue):-
    length(Reeks, Clue).

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
