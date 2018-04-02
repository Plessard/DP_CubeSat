clear 
format long
prop_time;
%t_span = linspace(tstart,tend,tstep);
t_span = 0:1:500;
% Initial Conditions
omega_sat_0 = [0.25 0.4 -0.1]';
omega_wheel_0 = 0;
epsilon_0 = [0 0 0]';
eta_0 = 1;

IC = [omega_sat_0;omega_wheel_0; epsilon_0; eta_0];

[t, x_out] = ode45('eq_motion2', t_span, IC);

% figure;
% plot(t,x_out(:,1:3), 'b--');
%plot(t,dw,'r')



post_processing2;
plot(t,omega_sat);