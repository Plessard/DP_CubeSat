% I is the moment of inertia without the wheel
I = diag([113209925.22, 157664078.25, 178851595.39])/(10^6);

% Iw is the moment of inertia of the wheel
% wheel inertia values from : https://www.researchgate.net/publication/251889729_Reaction_wheel_design_for_CubeSats
Iw = diag([1.67, 1.67, 1.67])/(10^3);

%Is is the total moment of inertia including the wheel
Is = I + Iw - Iw(3,3);