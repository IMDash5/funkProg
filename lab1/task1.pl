% Реализация стандартных предикатов обработки списков

% 1. Подсчет длины списка
newLength([], 0).
newLength([_|Tail], Length) :-
    newLength(Tail, TailLength),
    Length is TailLength + 1.

% 2. Проверка, что элемент принадлежит списку
member(Element, [Element|_]).
member(Element, [_|Tail]) :-
    member(Element, Tail).

% 3. Конкатенация двух списков
append([], List, List).
append([Head|Tail], List, [Head|Result]) :-
    append(Tail, List, Result).

% 4. Удаление элемента из списка
remove(Element, [Element|Tail], Tail).
remove(Element, [Head|Tail], [Head|Result]) :-
    remove(Element, Tail, Result).

% 5. Перестановки элементов списка
permute([], []).
permute(List, [Element|PermTail]) :-
    remove(Element, List, Rest),
    permute(Rest, PermTail).

% 6. Подсписки
sublist([], _).
sublist([Head|SubTail], [Head|Tail]) :-
    sublist(SubTail, Tail).
sublist(Sublist, [_|Tail]) :-
    sublist(Sublist, Tail).

% 7. Отделение хвоста списка, начиная с элемента с данным значением (без стандартных предикатов)
tail_from_value(Value, List, Tail) :-
    tail_helper(Value, List, Tail).

tail_helper(Value, [Value|Tail], Tail).
tail_helper(Value, [_|Tail], Result) :-
    tail_helper(Value, Tail, Result).

% 8. Отделение хвоста списка, начиная с элемента с данным значением (с стандартными предикатами)
tail_from_value_std(Value, List, Tail) :-
    sublist([Value|Tail], List).

% 9. Вычисление произведения элементов списка двумя способами

% Без использования стандартных предикатов
product([], 1). % Умножение на 1
product([Head|Tail], Product) :-
    product(Tail, TailProduct),
    Product is Head * TailProduct.

% С использованием стандартных предикатов
product_std(List, Product) :-
    length(List, Length),
    Length > 0,
    product_helper(List, Product).

product_helper([], 1).
product_helper([Head|Tail], Product) :-
    product_helper(Tail, TailProduct),
    Product is Head * TailProduct.

% Предикат совместного исрользования

product_after_value(Value, List, Product) :-
    tail_from_value(Value, List, Tail),
    product(Tail, Product).

% Пример использования
% ?- product_after_value(3, [1, 2, 3, 4, 5], Product).
% Product = 20.