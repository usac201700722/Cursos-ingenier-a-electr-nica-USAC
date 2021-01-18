function H = Tr(r)
%% Tr
% Programador:  Dr. Juan Carlos C�rdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Tr(r)
%
%% Par�metros de entrada
% r     - Vector 1x3, 3x1, 1x4 o 4x1 que representa cu�nto es la
%         traslaci�n.
%
%% Par�metros de salida
% H     - Matriz homog�nea de traslaci�n pura.
%
%% Descripci�n
% Produce una matriz homog�nea que representa una traslaci�n pura de
% acuerdo con las primeras tres componentes del vector r (la cuarta debe
% ser un 1 debido a la representaci�n homog�nea).

H = eye(4);
r = r(:);

r(4) = 1;
r = r(1:4);

H(:,4) = r;
