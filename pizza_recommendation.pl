
:- consult('getyesno.pl').
:- consult('pizza_db.pl').


start:-
  write('Hi. Welcome to pizza recommendation system - PRS'),nl,
  write('Answer all questions with Y for yes or N for no.'),nl,
  clear_stored_answers,
  ask.

validate_pizza(PizzaIndex,NumberOfPizzas):-
  nl,write('Chose which pizza you want, by choosing the correct number:'),
  nl,write('e.g. 0.'),
  nl, write('     '),
  read(PizzaIndex),nl,
  PizzaIndex >= 0,PizzaIndex < NumberOfPizzas,!.

validate_pizza(PizzaIndex,NumberOfPizzas):-
  write('Invalid pizza index. Please try again. '),nl,
  write('choose number between 0 and '),write(NumberOfPizzas),nl,

  write(PizzaIndex),
  validate_pizza(PizzaIndex,NumberOfPizzas).
    
  
ask:-
  all_questions(X,Y),
  nl,nl,
  write('Recommended pizzas:'),
  nl,
  recommended_pizzas(A,no),
  next(A, 0),

  % check if number is correct
  count(A, NumberOfPizzas), 
  validate_pizza(_, NumberOfPizzas),
  match(A, C, X), % A - list of pizzas, C - number of pizza, X - name of pizza
  write('How many pizza'),
  write(X),
  write(' you want ?'),
  read(M),
  nl,
  write('You chosed '),
  write(M),
  write(' time, pizza '),
  write(X), % X - name of pizza
  nl,nl,
  write('Ingridients: '),
  write('     '),
  nl,
  pizza(X, I),
  next_simple(I),
  nl,nl,
  write('The final cost is '),
  price(X, P),
  Z is M*P,
  write(Z),
  write('$.').



  





  

clear_stored_answers :- retract(stored_answer(_,_)),fail.
clear_stored_answers.

% ZWRACA TRUE JESLI ŻADEN ELEMENT LISTY NIE NALEŻY DO X
not_have(X, []).

not_have(X,[H|T]):-
  not(type(X, H)),
  not_have(X, T).


% ZWRACA PICKI(X) które nie mają danych typów składników
% np. without(margherita, meat) return true
without(_, []).

without(X, [H|T]):-
  pizza(X, Z),
  not_have(H, Z),
  without(X, T).


% uruchom tą regułę
%   np. match_pizzas_without(X, [seafood, muschrooms])

%zwróci wszystkie picki bez danych typów składnikow
% X -  [meat, cheese, init]
match_pizzas_without(X, Y):-
  findall(X, without(X, Y), X).


all_questions(X, Y):-
  setof(X, Y^type(X,Y), R),
  ask_question(R).
%  list_to_set(R, Set).



ask_question([]).

ask_question([H|T]):-
  user_says(H),
  ask_question(T).

% ask_question(X,_):-
%   type(X,Y),
%   user_says(X).
:- dynamic(stored_answer/2).

user_says(Q) :-  
  stored_answer(Q,A);
\+ stored_answer(Q,_),
  nl,nl,
  question_template(Q),
  get_yes_or_no(Response),
  asserta(stored_answer(Q,Response)),
  Response = A.

question_template(X) :-
  write('Do you like: '),
  write(X),
  write('?').



recommended_pizzas(X, A):-
  findall(Q, stored_answer(Q, A), Q),
  concatenate(Q, [init], R),
  % [init]
  match_pizzas_without(X, R).

% else

concatenate(List1, List2, Result):-
  append(List1, List2, Result).

next([], _).

next([H|T], C):-
    write('   '),
    write(C),write('.'),
    write(' '),write(H),
    nl,
    Z is C + 1,
    next(T, Z).

next_simple([]).

next_simple([H|T]):-
    write(H),
    write(' '),
    next_simple(T).


match([H|_],0,H).
match([_|T],N,H) :-
    N > 0, %add for loop prevention
    N1 is N-1,
    match(T,N1,H).
  
count([],0).
count([_|T],N) :-
    count(T,N1),
    N is N1+1.

    
