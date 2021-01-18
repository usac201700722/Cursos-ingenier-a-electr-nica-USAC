function [D,F,C] = CrearCilindro(r,h,dr,c,N)
%% CrearCilindro
% Autor: Dr. Juan Carlos C�rdova Zece�a.
% Fecha: Marzo de 2013.
%        Febrero de 2020.
%
%
%% Uso: 
%       [D,F,C] = CrearCilindro(r,h,dr,c,N);
%
%% Argumentos
% r     Radio exterior del cilindro. Por omisi�n es 1. (Siempre debe ser
%       positivo.)
% h     Altura del cilindro. Por omisi�n es 1. (Siempre debe ser positivo.)
% dr    Grueso del cilindro. Debe ser positivo y menor que r.
% c     Color del cilindro. Puede ser un n�mero, en cuyo caso representa un
%       �ndice del �nico color con el que se colorear� el cilindro, un
%       arreglo 1x3, que representa las componentes RGB del �nico color del
%       cilindro, un arreglo 3x1 que representa los �ndices de color de la
%       tapa, la orilla y la base del cilindro o un arreglo 3x3 que
%       representa las componentes RGB de la tapa, la orilla y la base del
%       cilindro.
% N     N�mero de segmento con los que se aproxima la circunferencia. Por
%       omisi�n es 20. (Siempre debe ser positivo.)
%
% D     Es la matriz de v�rtices del cilindro. Se da como una matriz de
%       vectores columna en coordenadas homog�neas.
% F     Es la matriz que representa las caras del cilindro.
% C     Es la matriz de colores de cada cara.
%
%% Descripci�n
% Esta funci�n crea las matrices de v�rtices, caras y colores
% correspondientes a un cilindro de altura h, de radio r, y de grueso dr
% que est� centrado en el origen y cuyo eje de simetr�a es el eje z.
%
% Estas matrices pueden luego ser usados con el comando patch:
%
% d = patch('Vertices',D(1:3,:)','Faces',F,'FaceVertexCData',C,'FaceColor','flat')
% 
% o con el comando MostrarObjeto:
%
% d = MostrarObjeto(D,F,C)
%

%% Implementaci�n
% Validaci�n
% En esta secci�n validamos la entrada.
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

if (nargin < 3)||(isempty(dr))
  dr = 0.1*r;
else
  dr = abs(dr);
  if dr > r
    dr = 0.1*r;
  end
end
if (nargin < 4)||(isempty(c))
  c = [0 0.5 0.5];
end

if (nargin < 5)||(isempty(N))
  N = 20;
else
  N = abs(N);
end

[fc,cc] = size(c);
if ~((cc == 1)||(cc==3))
  % Si ocurre un error, desplegar el siguiente mensaje y salir de la
  % funci�n.
  error('CrearCilindro:COLOR','El color debe ser o 1x1, o 1x3, o 3x1, o 3x3');
elseif fc == 1
  % Completamos c.
  c = [c;c;c];
elseif fc == 2
  c = [c; c(1,:)];
elseif fc > 3
  % S�lo conservamos las primeras tres filas.
  c = c(1:3,:);
end

%%
% Preparaci�n de espacio
% Creamos las matrices que ser�n llenadas con datos de v�rtices, caras y
% color.
D = zeros(4*(N+1),3);
F = zeros(8*N,3);
C = zeros(8*N,cc);

%%
% Procesamiento
% Procedemos con el rellenado de matrices.
ri = r-dr;      % Radio interior.


%%
% Esta secci�n crea todos los v�rtices exteriores.
for k = 0:N
  theta = k*2*pi/N;
  D(4*k+1,:) = [ri*cos(theta) ri*sin(theta) -h/2];
  D(4*k+2,:) = [ri*cos(theta) ri*sin(theta) h/2];
  D(4*k+3,:) = [r*cos(theta) r*sin(theta) h/2];
  D(4*k+4,:) = [r*cos(theta) r*sin(theta) -h/2];
end

D = D';

% Ahora lo convertimos a coordenadas homog�neas a�adiendo una cuarta
% componente con valor 1.
D(4,:) = 1;

%%
% Esta secci�n construye las caras (define c�mo se conectan los v�rtices
% para formar las caras) y les asigna color.
%
% La cara superior de cada uno de los N segmentos en los que se divide el
% disco est� formado por tres v�rtices, lo mismo que la cara inferior; por
% eso la matriz F tiene 3 columnas (debe conectar tres v�rtices. Sin
% embargo, la orilla tiene cuatro v�rtices. Como no podemos mezclar caras
% de tres v�rtices con caras de cuatro v�rtices (requerir�a que la matriz F
% tuviera, en algunos caso, tres columnas, y en otros, cuatro) dividimos la
% cara de la orilla en dos caras de tres v�rtices.

for k = 1:N
  F(8*(k-1)+1,:) = [4*(k-1)+1 4*(k-1)+2 4*(k-1)+6];   % Orilla interior.
  C(8*(k-1)+1,:) = c(2,:);                            % 
  F(8*(k-1)+2,:) = [4*(k-1)+1 4*(k-1)+6 4*(k-1)+5];   % 
  C(8*(k-1)+2,:) = c(2,:);                            % 
  F(8*(k-1)+3,:) = [4*(k-1)+2 4*(k-1)+3 4*(k-1)+7];   % Cara superior.
  C(8*(k-1)+3,:) = c(1,:);                            % 
  F(8*(k-1)+4,:) = [4*(k-1)+2 4*(k-1)+7 4*(k-1)+6];   %
  C(8*(k-1)+4,:) = c(1,:);                            %
  F(8*(k-1)+5,:) = [4*(k-1)+3 4*(k-1)+4 4*(k-1)+8];   % Orilla exterior.
  C(8*(k-1)+5,:) = c(2,:);                            % 
  F(8*(k-1)+6,:) = [4*(k-1)+3 4*(k-1)+8 4*(k-1)+7];   % 
  C(8*(k-1)+6,:) = c(2,:);                            % 
  F(8*(k-1)+7,:) = [4*(k-1)+1 4*(k-1)+5 4*(k-1)+8];   % Cara inferior.
  C(8*(k-1)+7,:) = c(3,:);                            % 
  F(8*(k-1)+8,:) = [4*(k-1)+1 4*(k-1)+8 4*(k-1)+4];   % 
  C(8*(k-1)+8,:) = c(3,:);                            % 
end