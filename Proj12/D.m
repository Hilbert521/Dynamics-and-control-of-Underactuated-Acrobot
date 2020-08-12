function inertia_mat = D(y, c)
% y is 1x2 matrix = [q1 q2]
% inertia_mat is 2x2 matrix

[g, m1, m2, l1, l2, r1, r2] = deal(c{:});

inertia_mat = zeros(2,2);
inertia_mat(1, 1) = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(y(1, 2))) + Izz(m1, l1, r1) + Izz(m2, l2, r2);
inertia_mat(2, 1) = m2 * ((l2*r2)^2 + l1*l2*r2*cos(y(1, 2))) + Izz(m2, l2, r2);
inertia_mat(1, 2) = inertia_mat(2,1);
inertia_mat(2, 2) = m2 * (l2*r2)^2 + Izz(m2, l2, r2);
end