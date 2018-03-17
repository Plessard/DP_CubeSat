% vector with the keplerian elements:
%		(1) - semimajor axis of the orbit in meters.
%		(2) - eccentricity.
%		(3) - inclination in radians.
%		(4) - right ascension of ascending node in radians.
%		(5) - argument of perigee in radians.
%		(6) - mean anomaly in radians.
%       Obs: 4,5 and 6 are not used

% Values taken from STk for SSO always in sunlight
semi_axis = 6978.14*1000; % (1)
ecc = 1.84712e-16; % (2)
inc = 97.7924 * 180/pi; % (3)
raan = 2.20753e-17*180/pi; % (4)
per = 0; % (5)
anomaly = 5.01593e-17 *180/pi; % (6)

kepel = [semi_axis, ecc, inc, raan, per, anomaly];

% Orbit state vector:
stat = kepel_statvec(kepel);

% Compute the variations in keplerian elements due to the Earth oblateness
delk = delkep(kepel);