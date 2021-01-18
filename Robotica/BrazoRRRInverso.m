function P=BrazoRRRInverso(d1,a2,a3,d6,T)
%d1,a2,a3,d6 parametros DH
%T pose deseada del manipulado final
%P matriz de configuraciones que clocan al robo en la pose deseada

%muñeca esferica
Rc = T*[0,0,-d6,1]';
xc = Rc(1);
yc = Rc(2);
zc = Rc(3);
P = zeros(8,6);

%%th posibles
t1a = atan2(xc,yc);
t1b = atan2(-xc,-yc);

P(1:4,1)= t1a;
P(5:8,1)= t1b;

D = (xc^2+yc^2+(zc-d1)^2-a2^2-a3^2)/(2*a2*a3);
t3aa = atan2(sqrt(1-D^2),D);
t3ab = atan2(-sqrt(1-D^2),D);

t2aa = atan2(zc-d1,sqrt(xc^2+yc^2))-atan2(a3*sin(t3aa),a2+a3*cos(t3aa));
t2ab = atan2(zc-d1,sqrt(xc^2+yc^2))-atan2(a3*sin(t3ab),a2+a3*cos(t3ab));

P(1:2,2)=t2aa;
P(3:4,2)=t2ab;

P(1:2,3) = t3aa;
P(3:4,3) = t3ab;

t2ba = pi-t2aa
t2bb = pi-t2ab;

t3ba = -t3aa;
t3bb = -t3ab;


P(5:6,2)=t2ba;
P(7:8,2)=t2bb;

P(5:6,3)=t3ba;
P(7:8,3)=t3bb;


for j = 1:2
    t1 = P(1+(j-1)*4,1);
    for k = 1:2
        t2 =P(1+(k-1)*2+(j-1)*4,2);
        t3 =P(1+(k-1)*2+(j-1)*4,3);
        A1 = DH(0,pi/2,d1,t1);
        A2 = DH(a2,0,0,t2);
        A3 = DH(a3,0,0,t3);
        A13= A1*A2*A3;
        R=A13\T;
        AZYZ= AngulosEulerZYZ(R);
        P(1+(k-1)*2+(j-1)*4,4:6)=[AZYZ(1,1),AZYZ(1,2),AZYZ(1,3)];
        P(1+(k-1)*2+(j-1)*4+1,4:6) = [AZYZ(2,1),AZYZ(2,2),AZYZ(2,3)];
    end
end

        
end
