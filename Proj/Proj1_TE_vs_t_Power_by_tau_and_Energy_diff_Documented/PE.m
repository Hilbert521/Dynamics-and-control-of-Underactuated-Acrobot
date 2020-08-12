function p = PE(y, c)
% y is no_time_stepx2 matrix
% p is no_time_stepx1 matrix
% c is row vector of constants ([g, m1, m2, l1, l2, r1, r2])
t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
p = (m1*l1*r1 + m2*l1) * g * sin(y(:, 1)) + m2*l2*r2*g * sin(y(:, 1)+y(:, 2));
end

