function dcm = quat_to_dcm(epsilon, eta)
format long

a11 = eta^2 + epsilon(1)^2 - epsilon(2)^2 - epsilon(3)^2;
a12 = 2*(epsilon(1)*epsilon(2) + eta*epsilon(3));
a13 = 2*(epsilon(1)*epsilon(3) - eta*epsilon(2));

a21 = 2*(epsilon(1)*epsilon(2) - eta*epsilon(3));
a22 = eta^2 - epsilon(1)^2 + epsilon(2)^2 - epsilon(3)^2;
a23 = 2*(epsilon(2)*epsilon(3) + eta*epsilon(1));

a31 = 2*(epsilon(1)*epsilon(3) + eta*epsilon(2));
a32 = 2*(epsilon(2)*epsilon(3) - eta*epsilon(1));
a33 = eta^2 - epsilon(1)^2 - epsilon(2)^2 + epsilon(3)^2;

dcm = [a11 a12 a13;
       a21 a22 a23;
       a31 a32 a33];