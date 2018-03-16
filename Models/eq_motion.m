function dx = eq_motion(x, L)

% load constants    
constants;

% get x into better form
omega_sat = x(1:3);
omega_wheel = x(4);
epsilon = x(5:7);
eta = x(8);
% L is disturbance torque data imported
us = -L(3);

% all terms are measure in the satellite body frame 
% omega_wheel eq. ignores omega of satellite 
dx = [inv(Is)*(-cross(omega_sat)*Is*omega_sat+(-cross(omega_sat)*Is*(x(3)+omega_wheel)-us)*[0;0;1]);%OMEGA_SAT_DOT
      inv(Iw)*us;%including w(3) term, it becomes: inv(Iw)*us-w(3)_dot OMEGA_WHEEL_DOT
      0.5*omega_sat*(eta*eye(3)+cross(epsilon)); %EPSILON_DOT
      -0.5*omega_sat*epsilon']; %ETA_DOT
  
  