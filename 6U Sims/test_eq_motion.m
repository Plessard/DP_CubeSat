clear 
format long

tstart = 0;
tend = 2000;
tdiv = 2000;
t_span = linspace(tstart,tend,tdiv);

% Initial Conditions
omega_sat_0 = [1 2 -0.5]';
omega_wheel_0 = 1;
epsilon_0 = [0 0 0]';
eta_0 = 1;

IC = [omega_sat_0; omega_wheel_0; epsilon_0; eta_0];

options = [];

[t, x_out] = ode45('eq_motion', t_span, IC);

post_processing;
figure(1);
plot(t,T_rot);
figure(2);
plot(t,f_quat);