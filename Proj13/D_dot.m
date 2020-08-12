function Dd = D_dot(y, c)
% y is 1x4 matrix = [q1 q2 q1_dot q2_dot]
% inertia_mat is 2x2 matrix
[g, m1, m2, l1, l2, r1, r2] = deal(c{:});
e = -m2 * l1 * l2 * r2 * sin(y(1,2)) * y(1,4);
Dd = [2*e e; e 0];
end