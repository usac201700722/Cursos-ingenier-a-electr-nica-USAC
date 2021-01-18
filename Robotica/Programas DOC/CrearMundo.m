function [NF, EG] = CrearMundo(xmin,xmax,ymin,ymax,zmin,zmax)
%% CrearMundo
% Autor: Dr. Juan Carlos Cï¿½rdova Zeceña.
% Fecha: Marzo de 2013.
%        Febrero de 2014.
%        Febrero 2020.
%
% Uso:
%     [NF,EG] = CrearMundo(xmin,xmax,ymin,ymax,zmin,zmax);
%
%% Argumentos
% xmin,..., zmax  - Son los lï¿½mites del mundo.
%
% NF               - Número de la figura creada.
% EG               - Puntero al eje gráfico de la figura.
%
%% Descripción
% Esta funciï¿½n crea un mundo con los lï¿½mites especificados. El ï¿½rea grï¿½fica
% estï¿½ ajustada para que la escala en cada eje sea la misma.
%
% Generalmente no es necesario guardar ni la figura ni el puntero al eje
% grï¿½fico, pero se proporciona la funcionalidad para casos especiales
% (quizï¿½ se emplean muchas figuras o muchos ejes en una figura o ambas
% cosas).
%
% Luego de "construido" el mundo, se puede ploteando elementos o usando
% objetos "patch".

if nargin == 1
  prm = xmin;
  xmin = prm(1);
  xmax = prm(2);
  ymin = prm(3);
  ymax = prm(4);
  zmin = prm(5);
  zmax = prm(6);
end

NF = figure;
EG = axes;
axis('equal');
axis([xmin,xmax,ymin,ymax,zmin,zmax]);

axis('vis3d');
grid;
xlabel('x');
ylabel('y');
zlabel('z');

view(EG,45,45);
