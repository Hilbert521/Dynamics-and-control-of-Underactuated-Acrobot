function inertia_mat = D(y, c)
% y is 2x1 matrix = [q1; q2]
% inertia_mat is 2x2 matrix
t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
inertia_mat = zeros(2,2);
inertia_mat(1, 1) = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(y(2, 1))) + Izz(m1, l1) + Izz(m2, l2);
inertia_mat(2, 1) = m2 * ((l2*r2)^2 + l1*l2*r2*cos(y(2, 1))) + Izz(m2, l2);
inertia_mat(1, 2) = inertia_mat(2,1);
inertia_mat(2, 2) = m2 * (l2*r2)^2 + Izz(m2, l2);
end