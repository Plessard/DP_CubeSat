clear 
format long
prop_time;
t_span = linspace(tstart,tend,tstep);
%t_span = [0 50];
% Initial Conditions
omega_sat_0 = [1 -1 1]';
omega_wheel_0 = 0;
epsilon_0 = [0 0 0]';
eta_0 = 1;

IC = [omega_sat_0; omega_wheel_0; epsilon_0; eta_0];

options = [];

[t, x_out] = ode45('eq_motion', t_span, IC);

post_processing2;
figure(1);
plot(t,omega_sat);
% plot(t,T_rot);
% figure(2);
% plot(t,f_quat);
% title('quaternion constraint');