function[prv] = dcm2prv(dcm)

c11 = dcm(1,1);
c22 = dcm(2,2);
c33 = dcm(3,3);

angle = acos(c11 + c22 + c33 - 1);

prv = (1/(2*sin(angle))) * [dcm(2:3)-dcm(3:2); dcm(3:1)-dcm(1:3); dcm(1:2)-dcm(2:1)];