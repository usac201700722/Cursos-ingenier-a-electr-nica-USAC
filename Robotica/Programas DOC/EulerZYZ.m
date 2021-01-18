function R = EulerZYZ(phi,theta,psi)
%% EulerZYZ
% Programador:  Dr. Juan Carlos C�rdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% R = EulerZYZ(phi,theta,psi)
%
%% Par�metros de entrada
% phi, theta, psi - �ngulos de Euler.
%
%% Par�metros de salida
% R   - Matriz Rz(phi)*Ry(theta)*Rz(psi).
%
%% Descripci�n
%  Calcula la matriz R = Rz(phi)*Ry(theta)*Rz(psi)
%
R = Rz(phi)*Ry(theta)*Rz(psi);