function c_mat = C(y, c)
% y is 4x1 matrix = [q1; q2; q1_dot; q2_dot]
% c_mat is 2x2 matrix
t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
h = -m2*l1*l2*r2*sin(y(2,1));
c_mat = [h*y(4, 1) h*(y(3, 1)+y(4, 1)); h*(-y(3, 1)) 0];
end