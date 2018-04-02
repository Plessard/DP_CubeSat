%function B_torque = b_dot(k, b1,b2, w, tstep)
function [B_torque,m_tumble] = b_dot(k, b1, w)

%Approximation of b_dot
b_dot_approx = cross_matrix(b1) * w;
m_tumble = -k * b_dot_approx;
B_torque = cross_matrix(m_tumble)*b1;

% Actually derivative of b-field
% b_dot = (b1 - b2)/tstep;
% B_torque = -k * cross_matrix(b_dot) * b1;