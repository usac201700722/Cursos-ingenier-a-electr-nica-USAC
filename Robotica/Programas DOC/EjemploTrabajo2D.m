%% Especificando el trabajo en 2D.
% Tomemos el manipulador 

[NF,EG] = CrearMundo(-10,10,-10,10,-5,5);
 
[D,F,C] = CrearLapiz(0.05,2);
 
hlapiz = MostrarObjeto(D,F,C,EG);
 
% Dp = Tr([2,0,0])*D;
% set(hlapiz,'Vertices',Dp(1:3,:)')

ro = 2.5;
xo = 5;
yo = 5;

xf = xo;
yf = yo;

N = 100;

for lambda = 0:2*pi/N:2*pi
  Twh = eye(4);
  Twh(:,4) = [(xo + ro*cos(lambda)) ; (yo + ro*sin(lambda));0;1];
  
  Twh = Twh*Rz(lambda)*Rx(-pi/4);
  % Twh = Twh*Rx(-pi/4);
  
  Dw = Twh*D;
  set(hlapiz,'Vertices',Dw(1:3,:)');
  
  hold('on');
  plot([xf Twh(1,4)],[yf Twh(2,4)],':r');
  hold('off');
  xf = Twh(1,4);
  yf = Twh(2,4);
  pause(0.1);
end








%Twh = Twh*Rz(lambda)*Rx(-pi/4);
