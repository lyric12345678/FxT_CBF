function dxdt = odefcn(t,x)
global u_save
dxdt = zeros(2,1);
% time
t
h_ellipsoid=1-x(1)^2/16-x(2)^2/0.81;
h_circle=x(1)^2+x(2)^2-1;

% h_ellipsoid_partial=[x(1)/8,2*x(2)/0.81];   %Ellipsoid:h_ellipsoid=x(1)^2/16+x(2)^2/0.81-1
h_ellipsoid_partial=[-x(1)/8,-2*x(2)/0.81];   %Ellipsoid:h_ellipsoid=x(1)^2/16+x(2)^2/0.81-1
h_circle_partial=[2*x(1),2*x(2)];
cvx_begin quiet
variable u
minimize( norm(u) )
subject to
h_ellipsoid_partial*[-x(2)+x(1)^2+x(1)*u;x(1)+x(2)*tanh(x(2))+x(2)*u]>=0;
% h_circle_partial*[-x(2)+x(1)^2+x(1)*u;x(1)+x(2)*tanh(x(2))+x(2)*u]<=-1*h_circle^2-1*h_circle^0;
if h_circle>0
    h_circle_partial*[-x(2)+x(1)^2+x(1)*u;x(1)+x(2)*tanh(x(2))+x(2)*u]<=-10*h_circle^2-10*h_circle^0;
else
    h_circle_partial*[-x(2)+x(1)^2+x(1)*u;x(1)+x(2)*tanh(x(2))+x(2)*u]<=0;
end
cvx_end
u_save=[u_save,u];
% figure(2)
% plot(t,u,'-*')
% hold on
dxdt(1) =-x(2)+x(1)^2+x(1)*u;
dxdt(2) = x(1)+x(2)*tanh(x(2))+x(2)*u;