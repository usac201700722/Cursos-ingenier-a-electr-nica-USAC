function A = DH(a,alpha,d,theta)
%% RBTK_DH
% Autor:  Juan Carlos Córdova Zeceña.
% Fecha:  Mayo de 2013 (documentación).
%         Noviembre de 2018.
%         Marzo de 2020.
%
% Uso:
%   
%     A = RBTK_DH(a,alpha,d,theta)
%     o
%     A = RBTK_DH(P)
%
%% Argumentos
%
% a       - Distancia a lo largo de x(i+1) para unir los orígenes del sistema 
%           i con el sistema i+1.
% alpha   - Ángulo alrededor de x(i+1) por el cual hay que rotar z(i) para 
%           alinearlo con z(i+1).
% d       - Distancia a lo largo de z(i) para unir los orígenes del sistema
%           i con el sistema i+1.
% theta   - Ángulo alrededor de z(i) por el cual hay que rotar x(i) para
%           alinearlo con x(i+1).
%
%% Descripción
% Esta función toma los parámetros de Denavit y Hartenberg y producen la
% matriz de transformación correspondiente.
%
% Si se invoca con un sólo parámetro, éste debe ser un vector con 4
% elementos [a alfa d theta].

if nargin == 1
  alpha = a(2);
  d = a(3);
  theta = a(4);
  a = a(1);
end

A = [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
     sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
     0           sin(alpha)             cos(alpha)                       d;
     0           0                      0                                1];
