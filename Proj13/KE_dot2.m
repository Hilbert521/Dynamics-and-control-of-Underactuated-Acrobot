function kp = KE_dot2(t, y, c)
% t is no_time_stepsx1 matrix
% y is no_time_stepsx4 matrix, y(i, :) = [q1i, q2i, q1_doti, q2_doti]
% kp = no_time_stepsx1 matrix
kp = zeros(size(y, 1), 1);
ang_a = alpha(t, y, c);     % [n, 2]
for i = 1:size(y, 1)
    Dd = D_dot(y(i, :), c);     % [2,2]
    i_mat = D(y(i, :), c);    % [2,2]
    kp(i, 1) = (y(i, 3) * ang_a(i, 1) * i_mat(1, 1) + (1/2) * Dd(1, 1) * y(i, 3)^2 ...
               + y(i, 3) * y(i, 4) * Dd(1, 2) + y(i, 4) * ang_a(i, 1) * i_mat(1, 2) + y(i, 3) * ang_a(i, 2) * i_mat(1, 2) ...
               + y(i, 4) * ang_a(i, 2) * i_mat(2, 2) + (1/2) * Dd(2, 2) * y(i, 4)^2);
end
end