orbit_parameters;
date_input;
prop_time;
sat_constants;

% Initial Conditions for ode45
omega_sat = [0.1 0.4 0.03];
omega_wheel = 0;
epsilon = [0 0 0];
eta = 1;

% Initial Vectors
time = tstart;          % to store time
orbit = stat';          % Orbit elements (state vector)
keorb = kepel';         % Orbit elements (keplerian)
earth_field = [0 0 0]';
grav_torque = [0 0 0]';
earth_magnitude = 0;
w_sat = omega_sat';
Time = tstart;
w_sat_plot = [];
sun_body_vector = [0 0 0]';
sun_eci_vector = [0 0 0]';

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
    
    if t2 <= tend
        [T, x_out] = ode45('eq_motion', tspan, IC);
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
    earth_field_magnitude = sqrt(earth_field_inertial(1)^2 + earth_field_inertial(2)^2 + earth_field_inertial(3)^2);
    earth_field_body = attitude*earth_field_inertial';
    % calculate sun position in ECI frame
    sun_eci = sun_dir(mjd,dfra);
    
    % calculate sun position in body frame
    sun_body = attitude*sun_eci;
    
    % increment fraction of day in seconds by the time step
    dfra = dfra + tstep;
    
    % TRIAD algorithm to determine attitude based on sensor measurements
    % attitude_measured = triad(attitude, sun_eci, sun_body,earth_field_inertial',earth_field_body);

    % Store data to be plotted
    time = cat(2, time, t);
    orbit = cat(2, orbit, stat');
    keorb = cat(2, keorb, kep2');
    earth_field = cat(2,earth_field,earth_field_inertial'); 
    earth_magnitude = cat(2,earth_magnitude, earth_field_magnitude);
    w_sat = cat(2, w_sat, omega_sat');
    w_sat_plot = cat(2, w_sat_plot, omega_sat_plot');
    Time = cat(2,Time,T');
    grav_torque = cat(2,grav_torque,torque_grav);
    sun_body_vector = cat(2,sun_body_vector, sun_body);
    sun_eci_vector = cat(2,sun_eci_vector, sun_eci);
end


plotting;


