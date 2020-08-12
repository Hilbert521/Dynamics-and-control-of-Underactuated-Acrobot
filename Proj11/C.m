function c_mat = C(y, c)
% y is 1x4 matrix = [q1 q2 q1_dot q2_dot]
% c_mat is 2x2 matrix

[g, m1, m2, l1, l2, r1, r2] = deal(c{:});
h = -m2*l1*l2*r2*sin(y(1,2));
c_mat = [h*y(1,4) h*(y(1,3)+y(1,4)); h*(-y(1,3)) 0];
end