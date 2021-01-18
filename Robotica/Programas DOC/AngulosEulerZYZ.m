function rslt = AngulosEulerZYZ(R)
%% AngulosEulerZYZ
% Programador:  Dr. Juan Carlos Córdova Z.
% Fecha:        Febrero de 2020.
%
%% Uso
%
% rslt = AngulosEulerZYZ(R)
%
%% Parámetros de entrada
% R     - Matriz de rotación, si es homogénea sólo se considera la submatiz
%         que corresponde a la rotación.. 
%
%% Parámetros de salida
% rslt  - matriz 2x3 que da, en filas separadas, las dos soluciones en
%         phi, theta, y psi que hacen que cumplen con
%           R = Rz(phi)*Ry(theta)*Rz(psi).
%         En la primera fila está la solución con sin(theta) positivo y la
%         segunda la solución con sin(theta) negativo.
%
%% Descripción
% Calcula los ángulos de Euler en representación de RzRyRz.
%
% Hay, en general, dos soluciones para R = Rz(phi)*Ry(theta)*Rz(psi), esta
% función entrega las soluciones en una matriz rslt de 2x3, la primera fila
% contiene los valores phi, theta, y psi tales que sin(theta) es positivo.
% La segunda fila contiene los valores correspondientes al caso sin(theta)
% negativo.
%
% Si sin(theta) = 0 (theta es 0 o pi, ocurre una situación degenerada en
% donde sólo la suma phi+psi o la diferencia psi - phi se puede determinar.
% En estos casos se presume phi = 0.

stheta = sqrt(1-R(3,3)^2);

if stheta < 1e-6
  % Para propósitos prácticos stheta es cero,.
  % En este caso sólo hay una solución, dependiendo del valor de cos(theta),
  % que es R(3,3). Duplicamos la solución para que el resultado sea siempre
  % de dos filas y tres columnas.
  
  if R(3,3) > 0
    theta1 = 0;
    phi1 = 0;
    psi1 = atan2(-R(1,2),R(1,1));
  else
    theta1 = pi;
    phi1 = 0;
    psi1 = -atan2(-R(1,2),-R(1,1));
  end  
  theta2 = theta1;
  phi2 = phi1;
  psi2 = psi1;
  
else
  % Solución con sin(theta) > 0.
  theta1 = atan2(stheta,R(3,3));
  phi1 = atan2(R(2,3),R(1,3));
  psi1 = atan2(R(3,2),-R(3,1));

  % Solución con sin(theta) < 0.
  theta2 = atan2(-stheta,R(3,3));
  phi2 = atan2(-R(2,3),-R(1,3));
  psi2 = atan2(-R(3,2),R(3,1));
end


rslt = [phi1 theta1 psi1;
        phi2 theta2 psi2];