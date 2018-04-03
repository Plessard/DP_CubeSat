clear;
orbit_parameters;
date_input;
prop_time;
sat_constants;

% Initial Conditions for ode45
omega_sat = [0.016 0.005 -0.02];
omega_wheel = 0;
% epsilon = [0 0 0];
% eta = 1;
eta = 0.182574185835055;
epsilon = [0.365148371670111 0.547722557505166 0.730296743340221];

% Initial Vectors
initial_vectors;

% Reference values
% attitude_ref = [0 0 0 1]';
% w_ref = [0 0 0]';

for t = tstart:tstep:tend
    
    % Orbit propagation
    kep2 = kepel + delk*t;
    
    % To convert from keplerian elements to state vector (if needed)
    stat = kepel_statvec(kep2);
    
    % Initial conditions for ode45
    % See post_processing.m 
    IC = [omega_sat omega_wheel epsilon eta]';       
    t1 = t;
    t2 = t+tstep;
    tdiv = 10;
    tspan = linspace(t1,t2,tdiv);
    
    u_plot = applied_torques(epsilon,omega_sat);
    if t2 <= tend
        [T, x_out] = ode45('eq_motion', tspan, IC,skip,L,T_bdot,t_wheel);
        post_processing; 
    end
    
    % calculate gravity gradient torque
    torque_grav = gravity_torque(stat(1:3)',attitude,Is);
    
    % To convert from inertial state vector to terrestrial vector
    % mag_field function only take terrestial vector as input
    geoc = inertial_to_terrestrial(gst(mjd, dfra+t), stat);
    
    % compute magnetic field in terrestial coordianates
    earth_field_terrestial = mag_field(mjd,geoc);
    
    %Convert to inertial frame 
    angle = gst(mjd, dfra+t); % angle [rad] between from terrestial to inertial frame
    earth_field_inertial = earth_field_terrestial'*rotmaz(-angle)';
    % earth_field_magnitude = sqrt(earth_field_inertial(1)^2 + earth_field_inertial(2)^2 + earth_field_inertial(3)^2);
    % temp_earth_field_b = earth_field_body;
    earth_field_body = attitude*earth_field_inertial';
    % calculate sun position in ECI frame
    sun_eci = sun_dir(mjd,dfra);
    
    % calculate sun position in body frame
    sun_body = attitude*sun_eci;
    
    % increment fraction of day in seconds by the time step
    
    % TRIAD algorithm to determine attitude based on sensor measurements
    % quaternion_measured = triad(attitude, sun_eci, sun_body, earth_field_inertial',earth_field_body);
    
    % Total Disturbance Torque in the B-Frame
    L = 0.1*earth_field_body + torque_grav; % this torque needs to be countered by a control torque
    % Geometric control decomposition - Forbes Method
    b_hat = earth_field_body/norm(earth_field_body);
%     u_perp = (cross_matrix(b_hat))' * cross_matrix(b_hat) * u;
%     u_parr = b_hat * b_hat' * u;

    k = 29000;
    % T_bdot = b_dot(k,earth_field_body,temp_earth_field_b,omega_sat',tstep);
    [T_bdot,dipole_bdot] = b_dot(k,earth_field_body,omega_sat');
    % t_wheel = [0;0;0];
        
%     if abs(omega_sat(1)) > 0.01 && abs(omega_sat(2)) > 0.01 && abs(omega_sat(3)) > 0.01
%         k = 250000000;
%         T_bdot = b_dot(k,earth_field_body,temp_earth_field_b,omega_sat',tstep);
%         t_wheel = [0;0;0];
%         % t_torquers = [0;0;0];
%     else 
          t_wheel = [0;1;0]*(earth_field_body' * u_plot')/(earth_field_body(2));
          t_torquers = (cross_matrix(b_hat))'*cross_matrix(b_hat)*(-t_wheel + u_plot');
%         T_bdot = [0;0;0];
%     end
   
    
    % Calculate max possible torque produced by torquers at each time interval
    % tm_max = cross_matrix(D)*earth_field_body;
    
    % Magnetic Dipole Calculation
    M = (cross_matrix(earth_field_body) * t_torquers)/(earth_field_body' * earth_field_body);
    % M = -cross_matrix(t_torquers)*earth_field_body;
    % TRIAD algorithm to determine attitude based on sensor measurements
    for i=1:length(quaternion_actual)
        attitude_triad = quat_to_dcm(quaternion_actual(1:3,i),quaternion_actual(4,i));
        Triad_out(:,i) = triad(attitude_triad, sun_eci, sun_body, earth_field_inertial',earth_field_body);
    end
    
    epsilon = Triad_out(2:4,end)';
    eta = Triad_out(1,end)';
    
    
    
    dfra = dfra + tstep;

    % Store data to be plotted
    time = cat(2, time, t);
    orbit = cat(2, orbit, stat');
    keorb = cat(2, keorb, kep2');
    earth_field = cat(2,earth_field,earth_field_inertial'); 
    b_field_body = cat(2,b_field_body,earth_field_body);
    % earth_magnitude = cat(2,earth_magnitude, earth_field_magnitude);
    w_sat = cat(2, w_sat, omega_sat');
    w_sat_plot = cat(2, w_sat_plot, omega_sat_plot');
    Time = cat(2,Time,T');
    grav_torque = cat(2,grav_torque,torque_grav);
    sun_body_vector = cat(2,sun_body_vector, sun_body);
    sun_eci_vector = cat(2,sun_eci_vector, sun_eci);
    torque_out = cat(2,torque_out,u_plot');
    
    torque_wheel = cat(2,torque_wheel,t_wheel);
    torque_torquers = cat(2,torque_torquers, t_torquers);
    Dipole= cat(2,Dipole,dipole_bdot);
    Moment = cat(2,Moment,M);
    
%     determinant = cat(2,determinant,deter);
%     rot_energy = cat(2,rot_energy,Trot);
%     quaternion_check = cat(2,quaternion_check,f_quat);

%     EPSILON = cat(2,EPSILON,quaternion_plot);
    Triad = cat(2,Triad,Triad_out);
    

end
% plot(time,Dipole);
% plot(Time,Triad);
plot(time,Moment)
xlabel('Mag moments of torquers');

% plot(time,torque_out);
% legend('w1','w2','w3');

figure;
plot(time,torque_wheel);
xlabel('wheel');
% 
% figure;
% plot(time,torque_torquers);
% xlabel('torquers');

plotting;

% figure(1);
% plot(time,determinant);
% xlabel('determinant');
% 
% figure(2);
% plot(time,quaternion_check);
% xlabel('quat');
% 
% figure(3);
% plot(time,rot_energy);
% xlabel('energy');

