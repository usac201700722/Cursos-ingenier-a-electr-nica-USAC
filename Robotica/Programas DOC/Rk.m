function H = Rk(k,theta)
%% Rk
% Programador:  Dr. Juan Carlos C�rdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Rk(theta)
%
%% Par�metros de entrada
% k     - Vector 1x3, 3x1, 1x4, 4x1. 
% theta - �ngulo, en radianes, de rotaci�n al rededor del eje k.
%
%% Par�metros de salida
% H     - Matriz homog�nea de rotaci�n pura.
%
%% Descripci�n
% Produce una matriz homog�nea que representa una rotaci�n pura al rededor
% del eje k por un �ngulo theta dado en radianes.

k = k(:);
k = k(1:3);

alpha = atan2(k(2),k(1));
beta = atan2(sqrt(k(1)^2+k(2)^2),k(3));

H = Rz(alpha)*Ry(beta)*Rz(theta)*Ry(-beta)*Rz(-alpha);


