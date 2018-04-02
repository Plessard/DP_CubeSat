function [q] = quat_mult(q,r)
% 'r' must be specified as a 4x1 vector

q_matrix = [q(4) -q(1) -q(2) -q(3);...
            q(1)  q(4)  q(3) -q(2);...
            q(2) -q(3)  q(4)  q(1);...
            q(3)  q(2) -q(1)  q(4)];
        
q = q_matrix*r;
        