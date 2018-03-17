orbit_parameters;
date_input;
prop_time;

% Initial Vectors
time = tstart;          % to store time
orbit = stat';          % Orbit elements (state vector)
keorb = kepel';         % Orbit elements (keplerian)
earth_field = [0 0 0]';
earth_magnitude = 0;

for t = tstart:tstep:tend
    
    % Orbit propagation
    kep2 = kepel + delk*t;
    
    % To convert from keplerian elements to state vector (if needed)
    stat = kepel_statvec(kep2);
    
    % To convert from inertial state vector to terrestrial vector
    % mag_field function only take terrestial vector as input
    geoc = inertial_to_terrestrial(gst(mjd, dfra+t), stat);
    
    % compute magnetic field in terrestial coordianates
    earth_field_terrestial = mag_field(mjd,geoc);
    
    %Convert to inertial frame 
    angle = gst(mjd, dfra+t); % angle [rad] between from terrestial to inertial frame
    earth_field_inertial = earth_field_terrestial'*rotmaz(-angle)';
    earth_field_magnitude = sqrt(earth_field_inertial(1)^2 + earth_field_inertial(2)^2 + earth_field_inertial(3)^2);
    
    
    
    % Store data to be plotted
    time = cat(2, time, t);
    orbit = cat(2, orbit, stat');
    keorb = cat(2, keorb, kep2');
    earth_field = cat(2,earth_field,earth_field_inertial'); 
    earth_magnitude = cat(2,earth_magnitude, earth_field_magnitude);
end




figure(1)
subplot(2, 1, 1);
plot(time, orbit(1:3,:)/1000);
xlabel('Time (s)')
ylabel('Position (km)')
title('Satellite inertial position ')

subplot(2, 1, 2);
plot(time, orbit(4:6,:)/1000);
xlabel('Time (s)')
ylabel('Velocity (km/s)')
title('Satellite velocity')

figure(2)
subplot(2,1,1);
plot(time,earth_field(1:3,:));
xlabel('Time (s)');
ylabel('Earth Magnetic Field in Inertial Frame xyz (T)');


subplot(2,1,2);
plot(time,earth_magnitude);
xlabel('Time (s)')
ylabel('Earth Magnetic Field Magnitude in Inertial Frame(T)');

