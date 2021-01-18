function [D,F,C] = CrearLapiz(r,h,p,c,N)
%% CrearLapiz
% Autor: Dr. Juan Carlos Córdova Zeceña.
% Fecha: Octubre de 2016.
%        Octubre de 2019.
%        Febrero de 2020.
%
%% Uso: 
%       [D,F,C] = CrearLapiz(r,h,p,c,N);
%
%% Argumentos
% r     Radio exterior del lapiz. Por omisión es 1. (Siempre debe ser
%       positivo.)
% h     Altura total del  lápiz. Por omisión es 5. (Siempre debe ser positivo.)
% p     Fracción correspondiente a la punta del lápiz, por omisión es 0.2;
% c     Color del lápiz. Puede ser un número, en cuyo caso representa un
%       índice del único color con el que se coloreará el lápiz, un
%       arreglo 1x3, que representa las componentes RGB del único color del
%       lápiz, un arreglo 2x3 que representa los índices de color de la
%       del cuerpo y la punta del lápiz
% N     Número de segmento con los que se aproxima la circunferencia. Por
%       omisión es 20. (Siempre debe ser positivo.)
%
% D     Es la matriz de vértices del lápiz. Se da como una matriz de
%       vectores columna en coordenadas homogéneas.
% F     Es la matriz que representa las caras del lápiz.
% C     Es la matriz de colores de cada cara.
%
%% Descripción
% Esta función crea las matrices de v


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
  % Sólo hay un color disponible.
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



