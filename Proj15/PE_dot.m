function pp = PE_dot(y, c)
% y is no_time_stepsx4 matrix, y(:, i) = [q1i; q2i; q1_doti; q2_doti]
% pp = no_time_stepsx1 matrix
[g, m1, m2, l1, l2, r1, r2] = deal(c{:});
pp = (m1 * l1 * r1 + m2 * l1) * g * cos(y(:, 1)) .* y(:, 3) ...
    + m2 * l2 * r2 * g * cos(y(:, 1) + y(:, 2)) .* (y(:, 3) + y(:, 4));
end