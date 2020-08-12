function phi = Phi(y, c)
% y is 2x1 matrix = [q1; q2]
% phi is 2x1 matrix
t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
phi = zeros(2,1);
phi(1, 1) = (m1*l1*r1 + m2*l1) * g * cos(y(1,1)) + m2*l2*r2*g * cos(y(1,1)+y(2,1));
phi(2, 1) = m2*l2*r2*g * cos(y(1,1)+y(2,1));
end