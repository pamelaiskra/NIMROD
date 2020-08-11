function [long,lat] = convert(E,N)
% Converstion from OSGB coordinates to latitude and longitude
% Procedure explained in "C.2  Converting eastings and northings to latlon"
% from http://www.bnhs.co.uk/focuson/grabagridref/html/OSGB.pdf
a=6377563.396;
b=6356256.909;
e2=(a^2-b^2)/a^2;
N0=-100000;
E0=400000;
F0=0.9996012717;
fi0=49.0*pi/180;
lambda0=-2.0*pi/180;

fip=((N-N0)/(a*F0))+fi0;
n=(a-b)/(a+b);
M1=(1+n+(5/4*n^2)+(5/4*n^3))*(fip-fi0)-(3*n+3*n^2+21/8*n^3)*sin(fip-fi0)*cos(fip+fi0);
M2=(15/8*n^2+15/8*n^3)*sin(2*(fip-fi0))*cos(2*(fip+fi0))*35/4*n^3*sin(3*(fip-fi0))*cos(3*(fip+fi0));
M=b*F0*(M1+M2);

discr=N-N0-M;
if (discr>=0.01)
    fip=(discr/(a*F0))+fip;
end

nu=a*F0*(1-e2*(sin(fip)^2)^(-0.5));
ro=a*F0*(1-e2)*(1-e2*(sin(fip)^2)^(-1.5));
eta2=(nu/ro)-1;

tanfip=tan(fip);
secfip=sec(fip);

VII=tanfip/(2*ro*nu);
VIII=(tanfip/(24*ro*nu^3))*(5+3*tanfip^2+eta2-9*tanfip^2*eta2);
IX=(tanfip/(720*ro*nu^5))*(61+90*tanfip^2+45*tanfip^4);
X=secfip/nu;
XI=(secfip/(6*nu^3))*(nu/ro+2*tanfip^2);
XII=(secfip/(120*nu^5))*(5+28*tanfip^2+24*tanfip^4);
XIIA=(secfip/(5040*nu^7))*(61+662*tanfip^2+1320*tanfip^4+720*tanfip^6);

EE=E-E0;
format long;
lat=(fip-VII*EE^2+VIII*EE^4-IX*EE^6)*180/pi;
long=(lambda0+X*EE-XI*EE^3+XII*EE^5+XIIA*EE^7)*180/pi;
end
