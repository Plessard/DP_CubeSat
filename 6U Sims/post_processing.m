sat_constants;
format long
% extract states
omega_sat   = x_out(:,1:3);
omega_wheel = x_out(:,4);
epsilon     = x_out(:,5:7);
eta         = x_out(:,8);

for i=1:length(x_out)
    % get attitude matrix from quaternions
    attitude = quat_to_dcm(epsilon(i,:),eta(i));
    deter(i) = det(attitude);
    
    % Energy check
    T_rot(i) = 0.5*omega_sat(i,:)*Is*omega_sat(i,:)';
    
    % Quaternion constraint check --> f_quat should always be 0
    f_quat(i) = epsilon(i,:)*epsilon(i,:)' + eta(i)^2 - 1;
end
