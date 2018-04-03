function u = applied_torques(epsilon,omega_sat,earth_field_body)

kp = 0.0007;
kd = 0.0015;
u = -kp*epsilon - kd*omega_sat;


% M = (cross_matrix(earth_field_body) * t_torquers)/(earth_field_body' * earth_field_body);
% t_wheel = [0;1;0]*(earth_field_body' * u)/(earth_field_body(2));
% t_torquers = (cross_matrix(b_hat))'*cross_matrix(b_hat)*(-t_wheel + u);
% b_hat = earth_field_body/norm(earth_field_body);
% 
% if M > 0.25
%     M = 0.25;
% elseif M < -0.25
%     M = -0.25;
% end


    