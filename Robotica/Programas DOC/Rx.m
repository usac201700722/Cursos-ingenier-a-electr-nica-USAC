function H = Rx(theta)
%% Rx
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Rx(theta)
%
%% Parámetros de entrada
% theta - Ángulo, en radianes, de rotación al rededor del eje x.
%
%% Parámetros de salida
% H     - Matriz homogénea de rotación pura.
%
%% Descripción
% Produce una matriz homogénea que representa una rotación pura al rededor
% del eje x por un ángulo theta dado en radianes.

H = [1          0           0          0;
     0          cos(theta) -sin(theta) 0;
     0          sin(theta)  cos(theta) 0;
     0          0           0          1];
     