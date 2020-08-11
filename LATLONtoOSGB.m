function [E,N] = convert(lon,lat)
% Converstion from latitude and longitude to OSGB coordinates.
% Procedure explained in "C.1  Converting latitude and longitude to eastings and northings"
% from http://www.bnhs.co.uk/focuson/grabagridref/html/OSGB.pdf
a=6377563.396;
b=6356256.909;
e2=(a^2-b^2)/a^2;
N0=-100000;
E0=400000;
F0=0.9996012717;
fi0=49.0*pi/180;
lambda0=-2.0*pi/180;
fi=lat*pi/180;
lambda=lon*pi/180;

sinfi=sin(fi);
cosfi=cos(fi);
tanfi=tan(fi);

n=(a-b)/(a+b);
nu=a*F0*(1-e2*sinfi^2)^(-0.5);
ro=a*F0*(1-e2)*(1-e2*(sinfi^2)^(-1.5));
eta2=(nu/ro)-1;

M1=(1+n+(5/4*n^2)+(5/4*n^3))*(fi-fi0)-(3*n+3*n^2+21/8*n^3)*sin(fi-fi0)*cos(fi+fi0);
M2=(15/8*n^2+15/8*n^3)*sin(2*(fi-fi0))*cos(2*(fi+fi0))*35/4*n^3*sin(3*(fi-fi0))*cos(3*(fi+fi0));
M=b*F0*(M1+M2);

I=M+N0;
II=(nu/2)*sinfi*cosfi;
III=(nu/24)*sinfi*cosfi^3*(5-tanfi^2+9*eta2);
IIIA=(nu/720)*sinfi*cosfi^5*(61-58*tanfi^2+tanfi^4);
IV=nu*cosfi;
V=(nu/6)*cosfi^3*((nu/ro)-tanfi^2);
VI=(nu/120)*sinfi*cosfi^3*(5-tanfi^2+9*eta2);

LL=lambda-lambda0;

format long

N=I+II*LL^2+III*LL^4+IIIA*LL^6;
E=E0+IV*LL+V*LL^3+VI*LL^5;
fprintf('\nN = %.6f\nE = %.6f\n\n',N,E);

end




