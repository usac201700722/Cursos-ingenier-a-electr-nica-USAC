function H = Rk(k,theta)
%% Rk
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Rk(theta)
%
%% Parámetros de entrada
% k     - Vector 1x3, 3x1, 1x4, 4x1. 
% theta - Ángulo, en radianes, de rotación al rededor del eje k.
%
%% Parámetros de salida
% H     - Matriz homogénea de rotación pura.
%
%% Descripción
% Produce una matriz homogénea que representa una rotación pura al rededor
% del eje k por un ángulo theta dado en radianes.

k = k(:);
k = k(1:3);

alpha = atan2(k(2),k(1));
beta = atan2(sqrt(k(1)^2+k(2)^2),k(3));

H = Rz(alpha)*Ry(beta)*Rz(theta)*Ry(-beta)*Rz(-alpha);


