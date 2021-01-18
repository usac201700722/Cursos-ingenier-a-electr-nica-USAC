function R = EulerZYZ(phi,theta,psi)
%% EulerZYZ
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% R = EulerZYZ(phi,theta,psi)
%
%% Parámetros de entrada
% phi, theta, psi - Ángulos de Euler.
%
%% Parámetros de salida
% R   - Matriz Rz(phi)*Ry(theta)*Rz(psi).
%
%% Descripción
%  Calcula la matriz R = Rz(phi)*Ry(theta)*Rz(psi)
%
R = Rz(phi)*Ry(theta)*Rz(psi);