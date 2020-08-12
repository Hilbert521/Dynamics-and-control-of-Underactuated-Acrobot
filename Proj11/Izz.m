function I = Izz(m, l, r)
% I = moment of inertia of a rod of mass m and length l about axis prpendicular
%        to rod and passing through centre of mass
I = (m*(l^2)/3)*((1-r)^3 + r^3);
% I = 0;
end