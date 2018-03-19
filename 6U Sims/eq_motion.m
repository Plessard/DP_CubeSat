%function dx = eq_motion(x, L)
function [dx] = eq_motion(~,x)

% load constants    
sat_constants;

% get x into better form
omega_sat = x(1:3);
omega_wheel = x(4);
epsilon = x(5:7);
eta = x(8);
L = [0.00005;0.00005;0.00005];
%L = [0;0;0];
% L is disturbance torque data imported
us = 0;



% all terms are measure in the satellite body frame 
% omega_wheel eq. ignores omega of satellite 
dx1 = Is\(-cross_matrix(omega_sat)*Is*omega_sat - cross_matrix(omega_sat)*(Is*[0;0;1]*(x(3)+omega_wheel))-us*[0;0;1]+L);%OMEGA_SAT_DOT
dx2 = Iw(3,3)\us; 
dx3 = 0.5*(eta*eye(3)+cross_matrix(epsilon))*omega_sat; %EPSILON_DOT
dx4 = -0.5*epsilon'*omega_sat; %ETA_DOT

dx = [dx1;dx2-dx1(3);dx3;dx4];
end
  