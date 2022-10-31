% PICKI
pizza(margherita,[red_sauce, mozarella]).

pizza(pepperoni, [red_sauce, pepperoni, mozarella]).

pizza('frutti di mare', [red_sauce, provolone, shrimps]).

pizza('al funghi', [red_sauce,  mozarella, champignions]).


% RODZAJ SKŁĄDNIKA
type(cheese, mozarella).
type(cheese, provolone).
type(cheese, chedar).

type(meat, ham).
type(meat, prosciutto).
type(meat, bacon).
type(meat, salami).

type(seafood, shrimps).
type(seafood, shelfish).

type(spicy_food, chili).
type(spicy_food, pepperoni).

type(muschrooms, champignions).

type(tomatoes, red_sauce).

%PRICE
price(margherita, 15).
price(pepperoni, 20).
price('al funghi', 17).
price('frutti di mare', 25).