function [D,F,C] = CrearCono(r,h,c,N)
%% CrearCono
% Autor: Dr. Juan Carlos Córdova Zeceña.
% Fecha: Octubre de 2016.
%        Febrero 2020.
%
%% Uso: 
%       [D,F,C] = CrearCono(r,h,c,N);
%
%% Argumentos
% r     Radio exterior del cono. Por omisión es 1. (Siempre debe ser
%       positivo.)
% h     Altura del cono. Por omisión es 1. (Siempre debe ser positivo.)
% c     Color del cono. Puede ser un número, en cuyo caso representa un
%       índice del único color con el que se coloreará el cono, un
%       arreglo 1x3, que representa las componentes RGB del único color del
%       cono, un arreglo 2x3 que representa los índices de color de los
%       lados y la base
% N     Número de segmento con los que se aproxima la circunferencia. Por
%       omisión es 20. (Siempre debe ser positivo.)
%
% D     Es la matriz de vértices del cono. Se da como una matriz de
%       vectores columna en coordenadas homogéneas.
% F     Es la matriz que representa las caras del cono.
% C     Es la matriz de colores de cada cara.
%
%% Descripción
% Esta función crea las matrices de vértices, caras y colores
% correspondientes a un cono de altura h y de radio r
% que está centrado en el origen y cuyo eje de simetría es el eje z.
%
% Estas matrices pueden luego ser usados con el comando patch:
%
% d = patch('Vertices',D(1:3,:)','Faces',F,'FaceVertexCData',C,'FaceColor','flat')
% 
% o con el comando MostrarObjeto:
%
% d = MostrarObjeto(D,F,C)
%

%% Implementación
% Validación
% En esta sección validamos la entrada.
if (nargin < 1)||(isempty(r))
  r = 1;
else
  r = abs(r);
end

if (nargin < 2)||(isempty(h))
  h = 1;
else
  h = abs(h);
end

if (nargin < 3)||(isempty(c))
  c = [0 0.5 0.5];
end

if (nargin < 4)||(isempty(N))
  N = 20;
else
  N = abs(N);
end

[fc,cc] = size(c);
if ~((cc == 1)||(cc==3))
  % Si ocurre un error, desplegar el siguiente mensaje y salir de la
  % función.
  error('CrearCono:COLOR','El color debe ser o 1x1, o 1x3, o 2x1, o 2x3');
elseif fc == 1
  % Completamos c.
  c = [c;c];
elseif fc > 3
  % Sólo conservamos las primeras dos filas.
  c = c(1:2,:);
end

%%
% Preparación de espacio
% Creamos las matrices que serán llenadas con datos de vértices, caras y
% color.
D = zeros(N+3,3);
F = zeros(2*N,3);
C = zeros(2*N,cc);

%%
% Procesamiento


%%
% Esta sección crea todos los vértices exteriores.
for k = 0:N
  theta = k*2*pi/N;
  D(k+1,:) = [r*cos(theta) r*sin(theta) 0];
end

D(N+2,:) = [0,0,h];     % La punta del cono está sobre el eje z.
D(N+3,:) = [0,0,0];

D = D';

% Ahora lo convertimos a coordenadas homogéneas añadiendo una cuarta
% componente con valor 1.
D(4,:) = 1;

%%
% Esta sección construye las caras (define cómo se conectan los vértices
% para formar las caras) y les asigna color.


for k = 1:N
  % Definimos el lado del cono.
  F(k,:)= [k k+1 N+2];
  C(k,:) = c(1,:); 
  
  % Definimos la base.
  F(N+k,:) = [k+1,k,N+3];
  C(N+k,:) = c(2,:);                            % 
end