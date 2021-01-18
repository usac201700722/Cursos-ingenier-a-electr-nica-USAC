function H = Ry(theta)
%% Ry
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Ry(theta)
%
%% Parámetros de entrada
% theta - Ángulo, en radianes, de rotación al rededor del eje y.
%
%% Parámetros de salida
% H     - Matriz homogénea de rotación pura.
%
%% Descripción
% Produce una matriz homogénea que representa una rotación pura al rededor
% del eje y por un ángulo theta dado en radianes.

H = [ cos(theta) 0          sin(theta) 0;
      0          1          0          0;
     -sin(theta) 0          cos(theta) 0;
      0          0          0          1];