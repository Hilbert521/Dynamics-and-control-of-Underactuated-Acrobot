function kp = KE_dot(t, y, c)
% t is no_time_stepsx1 matrix
% y is no_time_stepsx4 matrix, y(i, :) = [q1i, q2i, q1_doti, q2_doti]
% kp = no_time_stepsx1 matrix
kp = zeros(size(y, 1), 1);
ang_a = alpha(t, y, c);
for i = 1:size(y, 1)
    kp(i, 1) = (1/2) * (ang_a(i, :) * D(y(i, 1:2).', c) * y(i, 3:4).' ...
                       + y(i, 3:4) * D(y(i, 1:2).', c) * ang_a(i, :).' ...
                       + y(i, 3:4) * D_dot(y(i, :), c) * y(i, 3:4).');
end
end