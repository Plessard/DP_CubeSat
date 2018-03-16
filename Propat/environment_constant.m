clear

orbit_parameters;
date;

% Propagation time in seconds:
tstart = 0;     % initial time (sec)
tstep = 1;    % step time (sec)
tend = 10800;     % end time (10 minutes)

% Initial vectors
time = tstart;          % to store time
orbit = stat';          % Orbit elements (state vector)
keorb = kepel';         % Orbit elements (keplerian)


for t = tstart:tstep:tend
    
    i = t+1;
    % Orbit propagation
    kep2 = kepel + delk*t;
    % To convert from keplerian elements to state vector (if needed)
    stat = kepel_statvec(kep2);
    
    % To convert from inertial state vector to terrestrial vector
        geoc = inertial_to_terrestrial(gst(mjd, dfra+t), stat);
    
        % Earth's magnetic field
        sphe = rectangular_to_spherical(geoc);
        alt = sphe(3)/1000;
        elong = sphe(1);
        colat = pi/2 - sphe(2);
        earth_field = 1.e-9*igrf_field (year_frac, alt, colat, elong);
        
        
        x(i) = earth_field(1);
        y(i) = earth_field(2);
        z(i) = earth_field(3);
        field_magnitude(i) = sqrt((x(i))^2+(y(i))^2+(z(i))^2);
        earth_mag_out(i,:) = [x(i); y(i); z(i)];
    
         % Store data to be plotted
    time = cat(2, time, t);
    orbit = cat(2, orbit, stat');
    keorb = cat(2, keorb, kep2');
end
figure
plot(time(2:end), x, 'r');
hold on;
plot(time(2:end), y, 'b');
hold on;
plot(time(2:end), z, 'g');
hold on 
plot(time(2:end),field_magnitude, 'b');
figure
subplot(2, 1, 1);
plot(time, orbit(1:3,:)/1000);
xlabel('Time (s)')
ylabel('Position (km)')
title('Satellite inertial position')
