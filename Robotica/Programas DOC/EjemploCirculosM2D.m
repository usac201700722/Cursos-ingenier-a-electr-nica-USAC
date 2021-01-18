%% EjemploCirculosM2D
% Este script permite experimentar con un manipulador plano que tiene una
% herramienta adosada (un lápiz).
%
% La posición deseada de la herramienta (respecto al espacio de trabajo)
% está dada por la matriz Twh que se calcula dentro del lazo parametrizado
% por lambda.
%
% La herramienta está sujeta al manipulador de la forma especificada por
% Tmh (constante).
%
% Los vértices que definen al lápiz (en el sistema al que está ligado)
% están dados por la matriz D (cada columna es un vértice).
%
% El manipulador tiene tres segmentos de tamaños apropiados para que la
% hoja esté dentro de su espacio de trabajo, pero está ubicado 5 cms por
% encima de ésta. Esto implica que la posición relativa de la herramienta
% respecto al manipulador final debe ser tal que le permita tocar la hoja.
%
% La posición "real" de la herramienta es la posición que adopta debido a
% la configuración del manipulador y a la forma en la que está agarrada la
% herramienta. Idealmente esta pose es también la pose deseada y se cumple
% que T0mTmh = T0wTwh.
%
% Tanto la herramienta "real" (adosada al manipulador) como la herramienta
% ideal (la que establece la pose deseada) pueden dejar trazas, la primera
% en rojo y la segunda en verde.
%
% Puede experimentar visualizando uno o más de los objetos mencionados
% ajustando las variables en la sección de Configuración para hacerlos o no
% visibles.
% 
%
%%
%% Configuración

MostrarManipulador = true;
MostrarLapizDelManipulador = true;
MostrarLapizDeseado = false;
DejarTrazaLapizDelManipulador = true;
DejarTrazaLapizDeseado = false;

%% Espacio de trabajo y su relación T0w respecto al sistema DH0.
% El sistema de trabajo estará en el centro de una hoja de 20cm x 20 cm, en
% el plano z = 0 (en el sistema de trabajo).
%
% Ubicaremos a nuestro manipulador plano fuera de la hoja de trabajo, y
% flotando 5 cms por encima de él:
%
% Esto implica que, visto desde el sistema DH0 el origen del sistema de
% trabajo está en (20,20,-5) y los vectores unitarios correspondientes de
% ambos sistemas son paralelos.

T0w = eye(4);
T0w(1:3,4) = [20,20,-5];

% El manipulador está dado por la siguiente tabla DH.
%
%   i     ai  alfai  di   thetai
%   1     a   0      0    theta1
%   2     a   0      0    theta2
%   3     a/4 0      0    theta3

%% Selección de "a"
% Seleccionamos la longitud de a de manera que la hoja esté en el espacio
% de trabajo.

a = (4/7)*sqrt(2)*30;
a3 = a/4;

%% Vértices
% Fijamos los vértices de los eslabones respecto a los sistemas de 
% referencia a los que están ligados.

he = a/20;
V1 = [-a, -he/2, 0, 1; 0,-he/2, 0, 1; 0, he/2, 0, 1; -a, he/2, 0, 1]';
V2 = [-a, -he/2, 0, 1; 0,-he/2, 0, 1; 0, he/2, 0, 1; -a, he/2, 0, 1]';
V3 = [-a3, -he/2, 0, 1; 0,-he/2, 0, 1; 0, he/2, 0, 1; -a3, he/2, 0, 1]';

%% Creamos el mundo
% Creamos un mundo suficientemente grande para visualizar el manipulador,
% el lápiz y el papel.
xmin = -20 -5;
xmax = a + a + a/4 + xmin + 5;

ymin = xmin;
ymax = xmax;

zmin = -1;
zmax = 10;


[NF,EG] = CrearMundo(xmin,xmax,ymin,ymax,zmin,zmax);


%% Hoja de papel
% Dibujamos la hoja de papel.

Vp = [-10,-10; 10,-10;10,10; -10,10];
hp = patch(Vp(:,1),Vp(:,2),[0.93,0.93,0.93]);


%% Manipulador en su posición 0.
[Rbt,T] = CD_RRR2D([0 pi/4 pi/4],a,a,a3);

%hold(EG,'on');
v1 = T0w\T{1,1}*V1;
v2 = T0w\T{1,2}*V2;
v3 = T0w\T{1,3}*V3;

%% Crear lápiz
% Crear el lápiz y mostrarlo.
[D,F,C] = CrearLapiz(0.05,10);
 
if MostrarLapizDelManipulador
  hlapiz = MostrarObjeto(D,F,C,EG);
end

if MostrarLapizDeseado
  hlapizD = MostrarObjeto(D,F,20*ones(size(C)),EG);
end
 
%% Especificar el trabajo
% Indicar dónde se quiere trazar el círculo (xo,yo) y el radio del círculo
% ro, respecto al espacio de trabajo.
%
% Indicar también con cuantos segmentos N se aproximará el círculo.

ro = 2.5;
xo = 5;
yo = 5;


%% Preparar variables que se emplearán para dejar una traza.
xf = xo;
yf = yo;

xoD = xo;
yoD = yo;

xfD = xo;
yfD = yo;

N = 100;

%% Forma en que la herramienta está siendo adosada a la manipulador final
% Tmh es la forma en que está agarrado el lápiz.
Tmh = Tr([0;0;-5])*Ry(pi/4);

% Después probar con Tmh =  Tr([0;0;-5])*Rx(-pi/4);
if MostrarManipulador
  p1 = patch(v1(:,1),v1(:,2),v1(:,3),[0.85,0.85,0.85]);
  p2 = patch(v2(:,1),v2(:,2),v2(:,3),[0.75,0.75,0.75]);
  p3 = patch(v3(:,1),v3(:,2),v3(:,3),[0.65,0.65,0.65]);
end

% Colocar el lápiz en el manipulador final.
TwhM = T0w\T{1,3}*Tmh;
Dl = TwhM*D;
if MostrarLapizDelManipulador
  set(hlapiz,'Vertices',Dl(1:3,:)');
end

for lambda = 0:2*pi/N:2*pi
  
  % Calculamos el Twh deseado.
  Twh = eye(4);
  Twh(:,4) = [(xo + ro*cos(lambda)) ; (yo + ro*sin(lambda));0;1];
  Twh = Twh*Rz(lambda)*Rx(-pi/4);
  
  % Caculamos T0m.
  T0m = T0w*Twh/Tmh;
  
  % Resolvemos para T0m:
  THTA = CI_RRR2D(T0m,a,a,a3);
  
  % Tomamos la primera solución y obtenemos la pose del manipulador.
  [Rbt,T] = CD_RRR2D(THTA(1,:),a,a,a3);
  
  v1 = T0w\T{1,1}*V1;
  v2 = T0w\T{1,2}*V2;
  v3 = T0w\T{1,3}*V3;

  if MostrarManipulador
    % Dibujamos el manipulador:    
    set(p1,'Vertices',v1(1:3,:)');
    set(p2,'Vertices',v2(1:3,:)');
    set(p3,'Vertices',v3(1:3,:)');
  end
  
  TwhM = T0w\T{1,3}*Tmh;
  Dl = TwhM*D;
  if MostrarLapizDelManipulador
    % Dibujamos el lápiz.
    set(hlapiz,'Vertices',Dl(1:3,:)');
  end
  
  Dw = Twh*D;
  if MostrarLapizDeseado
    % Dibujamos el lápiz.    
    set(hlapiz,'Vertices',Dw(1:3,:)');
  end
  
  % Graficamos las trazas.
  
  hold('on');
  
  if DejarTrazaLapizDelManipulador
    % Graficamos el trazo del lápiz que está siendo sujeto por el
    % manipulador.
    plot([xf TwhM(1,4)],[yf TwhM(2,4)],':r');
  end
  xf = TwhM(1,4);
  yf = TwhM(2,4);
  
  if DejarTrazaLapizDeseado
    % Graficamos el trazo del lápiz en la pose deseada.
    plot([xfD Twh(1,4)],[yfD Twh(2,4)],'-.g');

  end
  xfD = Twh(1,4);
  yfD = Twh(2,4);
  
  hold('off');
    
  pause(0.1);
end



