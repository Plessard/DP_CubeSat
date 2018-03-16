function cross_out = cross(x)
% takes 3x1 vector input and create cross matrix
cross_out = [ 0  -x(3) x(2);
             x(3)  0  -x(1);
            -x(2) x(1)  0 ];