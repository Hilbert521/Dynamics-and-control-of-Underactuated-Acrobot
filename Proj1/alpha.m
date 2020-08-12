function q_ddot = alpha(t, y, c)
% t is no_time_stepsx1 matrix
% y is no_time_stepsx4 matrix
% q_ddot is no_time_stepsx2 matrix
q_ddot = zeros(size(y, 1), 2);
for i = 1:size(y, 1)
    q_ddot(i, :) = (D(y(i, 1:2).', c) \ (-1*C(y(i, :).', c)*y(i, 3:4).' ...
                                         - Phi(y(i, 1:2).', c) + tau(t(i, 1)).')).';
end
end