sat_constants;
format long

% saves last value for each and then stored in IC for next timestep of ode45
omega_sat   = x_out(end,1:3);
omega_wheel = x_out(end,4);
epsilon     = x_out(end,5:7);
eta         = x_out(end,8);
% saves all values of omega_sat to be plotted from ode45 results
omega_sat_plot = x_out(:,1:3);

% attitude DCM
attitude = quat_to_dcm(epsilon,eta);

% energy and quaternion constraint check
% for i=1:length(x_out)
%     w_sat(i) = omega_sat(i,:);
%     % get attitude matrix from quaternions
%     attitude = quat_to_dcm(epsilon(i,:),eta(i));
%     deter(i) = det(attitude);
%     
%     % Energy check
%     T_rot(i) = 0.5*omega_sat(i,:)*Is*omega_sat(i,:)';
%     
%     % Quaternion constraint check --> f_quat should always be 0
%     f_quat(i) = epsilon(i,:)*epsilon(i,:)' + eta(i)^2 - 1;
% end
