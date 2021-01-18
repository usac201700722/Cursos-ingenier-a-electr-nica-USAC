function [D,F,C] = CrearLapiz(r,h,p,c,N)
%% CrearLapiz
% Autor: Dr. Juan Carlos C�rdova Zece�a.
% Fecha: Octubre de 2016.
%        Octubre de 2019.
%        Febrero de 2020.
%
%% Uso: 
%       [D,F,C] = CrearLapiz(r,h,p,c,N);
%
%% Argumentos
% r     Radio exterior del lapiz. Por omisi�n es 1. (Siempre debe ser
%       positivo.)
% h     Altura total del  l�piz. Por omisi�n es 5. (Siempre debe ser positivo.)
% p     Fracci�n correspondiente a la punta del l�piz, por omisi�n es 0.2;
% c     Color del l�piz. Puede ser un n�mero, en cuyo caso representa un
%       �ndice del �nico color con el que se colorear� el l�piz, un
%       arreglo 1x3, que representa las componentes RGB del �nico color del
%       l�piz, un arreglo 2x3 que representa los �ndices de color de la
%       del cuerpo y la punta del l�piz
% N     N�mero de segmento con los que se aproxima la circunferencia. Por
%       omisi�n es 20. (Siempre debe ser positivo.)
%
% D     Es la matriz de v�rtices del l�piz. Se da como una matriz de
%       vectores columna en coordenadas homog�neas.
% F     Es la matriz que representa las caras del l�piz.
% C     Es la matriz de colores de cada cara.
%
%% Descripci�n
% Esta funci�n crea las matrices de v


if (nargin < 1)||isempty(r)
  r = 1;
end

if (nargin < 2)||isempty(h)
  h = 5;
end

if (nargin < 3)||isempty(p)
  p = 0.2;
end

if (nargin < 4)||isempty(c)
  c = 20;
end

if (nargin < 5)||isempty(N)
  N = 20;
end

% Obtener la altura del cuerpo y la punta.
hcrpo = h*(1-p);
hpnta = h*p;

if length(c(:,1)) == 1
  % S�lo hay un color disponible.
  ccrpo = c;
  cpnta = c;
else
  ccrpo = c(1,:);
  cpnta = c(2,:);
end
  
% Construimos el cuerpo como un cilindro.
[Vcrpo,Fcrpo,Ccrpo] = CrearCilindro(r,hcrpo,r,ccrpo,N);
 % Necesitamos elevar este cuerpo:
 Vcrpo = Tr([0 0 hcrpo/2+hpnta]')*Vcrpo;
 

 % Construimos la punta como un cono.
 [Vpnta,Fpnta,Cpnta] = CrearCono(r,hpnta,cpnta,N);
 % Necesitamos rotar y trasladar el cono.
 Vpnta = Tr([0 0 hpnta]')*Rx(pi)*Vpnta;
 
 [D,F,C] = UnirObjetos(Vcrpo,Fcrpo,Ccrpo,Vpnta,Fpnta,Cpnta);



