function phi = Phi(y, c)
% y is 1x2 matrix = [q1 q2]
% phi is 1x2 matrix
t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
phi = zeros(1,2);
phi(1, 1) = (m1*l1*r1 + m2*l1) * g * cos(y(1,1)) + m2*l2*r2*g * cos(y(1,1)+y(1,2));
phi(1, 2) = m2*l2*r2*g * cos(y(1,1)+y(1,2));
end