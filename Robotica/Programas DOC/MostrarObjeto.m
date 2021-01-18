function h = MostrarObjeto(V,F,C,ho)
%% MostrarObjeto 
% Autor:  Juan Carlos C?rdova Zece?a.
% Fecha:  Abril de 2012.
%         Febrero de 2014.
%         Febrero 2020.
%
%% Uso:
%   
%     h = MostrarObjeto(V,F,C,ho)
%
%% Argumentos
% V    - Matriz de vértices. Los puntos se describen por vectores columna
%                            con tres elementos, o cuatro para considerar
%                            el caso de coordenadas homog?neas. Si se
%                            emplean coordenadas homog?neas, las
%                            coordenadas (x,y,z,w) son sustituidas por
%                            (x/w,y/w,z/w) y se crea, internamente, una
%                            matriz V con sólo 3 filas.
%                          
%                            La matriz V representa tantos vérticies como
%                            tiene columnas. As? que V es 3xN (o 4xN),
%                            donde N es el n?mero de vértices.
% F    - Matriz de caras.    Esta matriz indica cómo conectar los vértices
%                            en V para formar caras. Cada cara es un
%                            triángulo, así que F es Mx3, donde M es el
%                            número de caras y cada cara está definida por
%                            tres v?rtices
% C    - Matriz de color.    Tiene 3 columnas (para R, G y B) y puede tener
%                            tantas filas como caras hay en F.
%                            Tambi?n puede ser un n?mero o un arreglo de
%                            n?meros.
% ho   - Descriptor (handle) del eje gr?fico a emplear. Por omisi?n se usa
%        el actual.
%
%% Descripción
% Esta funci?n crea un objeto gr?fico (patch) basado en la definici?n de
% v?rtices descrita por la matriz V, y la matriz F que indica c?mo se deben
% visitar dichos v?rtices para formar cada cara del objeto.
%
% F es una matriz de Mx3 definiendo cada pol?gono de tres lados,
% representando cada uno de los M tri?ngulos que forman al objeto.
%
% V es la matriz de v?rtices de 3xN o 4xN que representa cada uno de los N 
% vértices del objeto, ya  sea en coordenadas normales (3xN) o en
% coordenadas homog?neas (4xN). Si se proporcionan coordenadas homog?neas,
% la funci?n crea una nueva matriz V de 3xN donde v(1,j) =V(1,j)/V(4,j),
% V(2,j) = V(2,j)/ V(4,j) y V(3,j) = V(3,j)/V(4,j).
%
% C es la matriz de colores, puede ser:
%
%   1. Una constante entera, especificando el valor del color de todas las
%      caras.
%   2. Una matriz de Mx1 de valores enteros especificando el color
%      (mediante un ?ndice en la tabla de colores) de cada cara.
%   3. Una matriz de Mx3 especificando, mediante una combinaci?n RGB, el
%      color de cada cara.
%
% Las especificaciones de colores pueden ser parciales, extendi?ndose el
% ?ltimo color para aquellas caras que no han sido especificadas
% expl?citamente.


if nargin < 4
  ho = gca;
end

axes(ho);

[filV,colV] = size(V);
[filF, ~] = size(F);
[filC,colC] = size(C);

if ~((filV == 3)||(filV==4))
  fprintf('MostrarObjeto: La matriz de vertices debe ser 3xN o 4xN.\n');
  return;
end

if filV > 3
  % Normalizamos las componentes normales con la cuarta componente de los
  % vectores en V.
  for idx = 1:colV
    V(1:3,idx) = V(1:3,idx)/V(4,idx);
  end
end

% Ahora aseguramos que V Nx, que es como lo requiere el comando patch.
V = V(1:3,:);
V = V';

filV = colV;


F = round(F);
if (min(min(F)) < 0)||(filV < max(max(F)))
  fprintf('MostrarObjeto: La matriz de especificaci?n de caras es incorrecta.\n');
  return;
end

if ~((colC == 1)||(colC == 3))
  fprintf('MostrarObjeto: La matriz de especificaci?n de colores es incorrecta.\n');
  return;
end


if filC<filF
  % No hay suficientes colores para toda las caras, as? que extendemos C:
  C(filC+1:filF,1) = C(filC,1);
  if colC == 3
    C(filC+1:filF,2) = C(filC,2);
    C(filC+1:filF,3) = C(filC,3);
  end
end

if filC>filF
  % Hay m?s colores que caras, corregir C.
  C = C(1:filF,:);
end


h = patch('Faces',F,'Vertices',V,'FaceVertexCData',C,'FaceColor','flat','EdgeAlpha',1,'FaceAlpha',0.9,'CDataMapping','direct','EdgeColor',[0.2 0.2 0.2]);