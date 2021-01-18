function H = Tr(r)
%% Tr
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% H = Tr(r)
%
%% Parámetros de entrada
% r     - Vector 1x3, 3x1, 1x4 o 4x1 que representa cuánto es la
%         traslación.
%
%% Parámetros de salida
% H     - Matriz homogénea de traslación pura.
%
%% Descripción
% Produce una matriz homogénea que representa una traslación pura de
% acuerdo con las primeras tres componentes del vector r (la cuarta debe
% ser un 1 debido a la representación homogénea).

H = eye(4);
r = r(:);

r(4) = 1;
r = r(1:4);

H(:,4) = r;
