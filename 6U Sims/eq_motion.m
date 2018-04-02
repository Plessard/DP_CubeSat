function [dx] = eq_motion(~,x,skip,L,T_bdot,t_wheel)

% load constants    
sat_constants;

% get x into better form
omega_sat = x(1:3);
omega_wheel = x(4);
epsilon = x(5:7);
eta = x(8);

if abs(omega_sat(1)) < 0.01 && abs(omega_sat(2)) < 0.01 && abs(omega_sat(3)) < 0.01
    kp = 5;
    kd = 10;
    u = -kp*epsilon - kd*omega_sat;
else
    u = 0;
    %t_wheel = 0;
end

% Control derived from Lyapunov functions V(dw,dE)
% u = -(cross_matrix(omega_sat)*Is*omega_sat + cross_matrix(omega_sat)*Iw*[0;0;1]*(omega_sat(3) + omega_wheel)...
%     - L - K*d_epsilon - P*dw + Is*(omega_ref_dot - cross_matrix(omega_sat)*omega_ref));
% us = u(3);

% all terms are measure in the satellite body frame 
dx1 = Is\(-cross_matrix(omega_sat)*Is*omega_sat - cross_matrix(omega_sat)*(Iw(2,2)*[0;1;0]*(x(2)+omega_wheel))+u*0+L+T_bdot);%OMEGA_SAT_DOT
if t_wheel(2) == 0
    dx2 = 0;
else  
    dx2 = Iw(2,2)\t_wheel(2) - dx1(2);
end 
dx3 = 0.5*(eta*eye(3)+cross_matrix(epsilon))*omega_sat; %EPSILON_DOT
dx4 = -0.5*epsilon'*omega_sat; %ETA_DOT

% dx = [dx1;dx2-dx1(2);dx3;dx4];
dx = [dx1;dx2*0;dx3;dx4];
end
  