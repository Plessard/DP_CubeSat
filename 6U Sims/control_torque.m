function u = control_torque(dw, d_epsilon,P, K, omega_ref_dot, omega_ref, omega_sat, omega_wheel, L)

sat_constants;

u = -(cross_matrix(omega_sat)*Is*omega_sat + cross_matrix(omega_sat)*Iw*[0;0;1]*(omega_sat(3) + omega_wheel)...
    - L - K*d_epsilon - P*dw + Is*(omega_ref_dot - cross_matrix(omega_sat)*omega_ref));
end 