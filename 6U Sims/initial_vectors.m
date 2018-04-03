time = tstart;          % to store time
orbit = stat';          % Orbit elements (state vector)
keorb = kepel';         % Orbit elements (keplerian)
earth_field = [0 0 0]';
grav_torque = [0;0;0];
torque_grav = [0;0;0];
earth_magnitude = 0;
earth_field_body = [0;0;0];
b_field_body = [0;0;0];
w_sat = omega_sat';
Time = tstart;
w_sat_plot = [];
sun_body_vector = [0 0 0]';
sun_eci_vector = [0 0 0]';
skip = 0;
tm_max = [0;0;0];
L = [0;0;0];
u = [0;0;0];
T_bdot = [0;0;0];
torque_wheel = [0;0;0];
torque_torquers = [0;0;0];
Dipole= [0;0;0];
t_wheel = [0;0;0];
t_torquers = [0;0;0];

EPSILON = [0;0;0;0];
Triad = [0;0;0;0];

Moment = [0;0;0];

torque_out = [0;0;0];
determinant = 1;
rot_energy = 0;
quaternion_check = 0;