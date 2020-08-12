function k = KE(y, c)
% y is no_time_stepx4 matrix, y(i, :) = [q1i q2i q1_doti q2_doti]
% k = no_time_stepx1 matrix
k = zeros(size(y, 1), 1);
for i = 1:size(y, 1)
    k(i, 1) = (1/2) * y(i, 3:4) * D(y(i, 1:2), c) * y(i, 3:4).';
end
end