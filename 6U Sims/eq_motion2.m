function dx = eq_motion(~,x)
% function [dx] = eq_motion(~,x,skip,torque_grav,torque_mag,tm_max)

% load constants    
sat_constants;

% get x into better form
omega_sat = x(1:3);
omega_wheel = x(4);
epsilon = x(5:7);
eta = x(8);

us = 0;
% all terms are measure in the satellite body frame 
% omega_wheel eq. ignores omega of satellite 
dx1 = Is\(-cross_matrix(omega_sat)*Is*omega_sat - cross_matrix(omega_sat)*(Is*[0;0;1]*(x(2)+omega_wheel)));%OMEGA_SAT_DOT
dx2 = Iw(2,2)\us; 
dx3 = 0.5*(eta*eye(3)+cross_matrix(epsilon))*omega_sat; %EPSILON_DOT
dx4 = -0.5*epsilon'*omega_sat; %ETA_DOT

dx = [dx1;dx2-dx1(2);dx3;dx4];
end