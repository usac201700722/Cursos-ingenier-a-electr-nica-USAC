function H = Rx(theta)
%% Rx
% Programador:  Dr. Juan Carlos C�rdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Rx(theta)
%
%% Par�metros de entrada
% theta - �ngulo, en radianes, de rotaci�n al rededor del eje x.
%
%% Par�metros de salida
% H     - Matriz homog�nea de rotaci�n pura.
%
%% Descripci�n
% Produce una matriz homog�nea que representa una rotaci�n pura al rededor
% del eje x por un �ngulo theta dado en radianes.

H = [1          0           0          0;
     0          cos(theta) -sin(theta) 0;
     0          sin(theta)  cos(theta) 0;
     0          0           0          1];
     