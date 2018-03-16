clear 

tstart = 0;
tstep = 1;
tend = 20;
t_span = linspace(tstart,tend,tstep);

% Initial Conditions
omega_sat_0 = [1 -1 1]';
omega_wheel_0 = 0;
epsilon_0 = [0 0 0]';
eta_0 = 1;

IC = [omega_sat_0; omega_wheel_0; epsilon_0; eta_0];

options = [];

[t, x_out] = ode45('eq_motion', t_span, IC);