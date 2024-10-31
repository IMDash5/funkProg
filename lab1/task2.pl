:- set_prolog_flag(encoding, utf8).
:- consult('one.pl').

% 1. Получение таблицы групп и среднего балла по каждой группе
average_grade(Group, Average) :-
    findall(Grade, (student(Group, Student), grade(Student, _, Grade)), Grades),
    sum_list(Grades, Total),
    length(Grades, Count),
    Count > 0,
    Average is Total / Count.

get_groups_average :-
    findall(Group, student(Group, _), Groups),
    list_to_set(Groups, UniqueGroups),
    write('Group'), write(' | Average'), nl,
    forall(member(Group, UniqueGroups), (
        average_grade(Group, Average),
        format('~w | ~2f~n', [Group, Average])
    )).

% 2. Список студентов, не сдавших экзамен (grade=2) для каждого предмета
failed_students_for_subject(Subject, FailedStudents) :-
    findall(Student, (grade(Student, Subject, 2)), FailedStudents).

get_failed_students :-
    findall(Subject, subject(Subject, _), Subjects),
    write('Subject'), write(' | Students, didn`t pass'), nl,
    forall(member(Subject, Subjects), (
        failed_students_for_subject(Subject, FailedStudents),
        format('~w | ~w~n', [Subject, FailedStudents])
    )).

% 3. Количество не сдавших студентов в каждой группе
failed_students_in_group(Group, Count) :-
    findall(Student, (student(Group, Student), grade(Student, _, 2)), FailedStudents),
    length(FailedStudents, Count).

get_failed_students_count_per_group :-
    findall(Group, student(Group, _), Groups),
    list_to_set(Groups, UniqueGroups),
    write('Group'), write(' | Amount not passed'), nl,
    forall(member(Group, UniqueGroups), (
        failed_students_in_group(Group, Count),
        format('~w | ~w~n', [Group, Count])
    )).

% Запуск всех трех функций
run :-
    get_groups_average,
    nl,
    get_failed_students,
    nl,
    get_failed_students_count_per_group.