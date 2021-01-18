function THTA = CI_RRR2D(R,a1,a2,a3)
x = R(1,4);
y = R(2,4);

calpha = R(1,1);
salpha = R(2,1);

alpha = atan2(salpha,calpha);

x2 = x - a3*calpha;
y2 = y - a3*salpha;

gamma = atan2(y2,x2);

h = sqrt(x2^2 + y2^2);

cbeta = (h^2 + a1^2 - a2^2)/(2*h*a1);
sbetamas = sqrt(1-cbeta^2);
sbetamenos = -sbetamas;

betamas = atan2(sbetamas,cbeta);
betamenos = atan2(sbetamenos,cbeta);

theta1mas = gamma - betamas;
theta1menos = gamma - betamenos;

theta2mas = atan2(h*sbetamas,h*cbeta-a1);
theta2menos = atan2(h*sbetamenos,h*cbeta-a1);

theta3mas = alpha - (theta1mas + theta2mas);
theta3menos = alpha - (theta1menos + theta2menos);

THTA = [theta1mas theta2mas theta3mas;theta1menos theta2menos, theta3menos];


