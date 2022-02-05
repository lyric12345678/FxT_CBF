clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Research Problem: Fixed-time control barrier function
%Author: Ming Li
%Date: Feb. 5. 2022
%Note: the simulation is a repeat of the result of example 1 in [1];
%[1] Control-Lyapunov and Control-Barrier Functions based Quadratic
%Program for Spatio-temporal Specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global u_save

Initial_position(:,1)=[3,0.4];
Initial_position(:,2)=[-3.2,0.4];
Initial_position(:,3)=[-3.1,-0.4];
Initial_position(:,4)=[3.3,-0.4];
for i=1:size(Initial_position,2)
    u_save=[];
    [T,x(:,:,i)] = ode45(@odefcn,[0:0.01:7],Initial_position(:,i));
    u_plot{i}=u_save;
end

%% Safety Set
% The first set is a circle
C_center_1=[0,0];
Radius_1=1;
%The second set is an ellipsoid
C_center_2=[0,0];
a=4;
b=0.9;
N_sampling=100;
C_theta_1=0:2*pi/N_sampling:2*pi;
C_theta_2=0:2*pi/N_sampling:2*pi;
for i=1:N_sampli
    x_1(:,i)=[C_center_1(1)+Radius_1*cos(C_theta_1(i)),C_center_1(2)+Radius_1*sin(C_theta_1(i))];
    x_2(:,i)=[C_center_2(1)+a*cos(C_theta_2(i)),C_center_2(2)+b*sin(C_theta_2(i))];
end
figure(1)
plot(x_1(1,:),x_1(2,:),'b--','linewidth',2)
hold on
plot(x_2(1,:),x_2(2,:),'r--','linewidth',2)
color=['r','b','k','m'];
for i=1:1:size(Initial_position,2)
    h(:,i)=plot(x(:,1,i),x(:,2,i),color(i),'linewidth',1); 
end
axis equal
xlabel('x1')
ylabel('x2')
legend([h(:,1),h(:,2),h(:,3),h(:,4)],'Initial 1','Initial 2','Initial 3','Initial 4')

color=['r','b','k','m'];
figure(2)
for i=1:size(Initial_position,2)
    subplot(2,2,i)
    plot(u_plot{i},color(i),'linewidth',1)
    str=strcat('Initial',num2str(i));
    legend(str,'Fontsize',12)
    axis equal
    xlabel('t')
    ylabel('u')
end
