function [V,F,C] = UnirObjetosGraficos(V1,F1,C1,V2,F2,C2)
%% UnirObjetosGraficos
% Autor: Dr. Juan Carlos Córdova Zeceña.
% Fecha: Marzo de 2013.
%        Febrero de 2014.
%        Febrero de 2020.
%
% Uso: 
%       [V,F,C] = UnirObjetosGraficos(V1,F1,C1,V2,F2,C2)
%
%% Argumentos
% V1    Matriz de vértices del primer objeto. 3xN o 4xN (si los vértices
%       están dados en coordendas homogéneas). Cada columna representa un
%       vértice.
% F1    Matriz de caras del primer objeto. Generalmente Mx3, puesto que
%       cada una de las M caras es generalmente un triángulo, pero podría 
%       ser Mxk, donde cada cara está especificada por un polígono de k
%       lados (no necesariamente regular).
% C1    Matriz de colores del primer objeto. Debe tener M filas (igual que
%       F1) y el número de columnas puede ser 1, si se trata de un índice
%       en la tabla de colores, o 3 si se trata de una especificación RGB.
% V2    Matriz de vértices del segundo objeto. 3xNp o 4xNp. El programa lo
%       convierte a 4xNp. Np es el número de vértices y no tiene
%       necesariamente que ser igual al número de columnas en V1.
% F2    Matriz de caras del segundo objeto Mpxk. Las columnas de éste deben
%       coincidir en número con las de F1.
% C2    Matriz de colores del segundo objeto. Debe tener igual número de
%       filas que F2 e igual número de columnas que C1.
%
% V     Matriz de vértices resultante. 4x(N+Np).
% F     Matriz de caras resultante. (M+Mp)xk (normalmente k=3).
% C     Matriz de colores resultante. (M+Mp)x1 o (M+Mp)x3, según sean
%       colores por índice o colores por especificación RGB.
%
%% Descripción
% Esta función une dos las descripciones de dos objetos gráficos de manera
% que V es la matriz con todos los vertíces de los objetos originales
% (Nx3), F es la matriz describiendo todas las caras juntas y C la matriz
% con los colores de cada cara.
% 
% Para que la operación tenga éxito las caras deben tener igual número de
% vértices. Por ello se recomienda que la descripción de caras se realice
% empleando sólo tres vértices.
% Estas matrices pueden luego ser usados con el comando patch:
%
% Nuevo_objeto = patch('Vertices',V(1:3,:)','Faces',F,'FaceVertexCData',C,'FaceColor','flat');
%

[FLA,Nbase] = size(V1);

if (FLA < 3)||(FLA > 4)
  error('UnirObjetosGraficos:Dimensiones','La matriz de vértices debe ser 3xN o 4xN');
end

if FLA == 3
  V1(4,:) = 1;
end
  
[FLA,~] = size(V2);

if (FLA < 3)||(FLA > 4)
  error('UnirObjetos:Dimensiones','La matriz de vértices debe ser 3xN o 4xN');
end

if FLA == 3
  V2(4,:) = 1;
end


V = [V1,V2];

F2 = F2 + Nbase;

F = [F1;F2];

C = [C1;C2];