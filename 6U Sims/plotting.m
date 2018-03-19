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
ylabel('B-field vector in ECI(T)');

subplot(2,1,2);
plot(time,earth_magnitude);
xlabel('Time (s)')
ylabel('B-field magnitude ECI(T)');

figure(4)
plot(Time(2:end), w_sat_plot);
xlabel('Time (s)')
ylabel('Angular velocity (rad/s)')
title('Angular velocity')

figure(5)
plot(time,grav_torque);
xlabel('Time (s)');
ylabel('Gravity Gradient Torque');

figure(6)
subplot(2,1,1);
plot(time,sun_eci_vector);
xlabel('Time (s)');
ylabel('Sun vector ECI');

subplot(2,1,2);
plot(time,sun_body_vector);
xlabel('Time (s)');
ylabel('Sun vector body frame');