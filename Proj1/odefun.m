function dydt = odefun(t, y, c)
% y = [q1; q2; q3; q4]
% dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
%           q3 = q1_dot and q4 = q2_dot
dydt = zeros(4, 1);
dydt(1:2, 1) = [y(3, 1); y(4, 1)];
dydt(3:4, 1) = -C(y, c)*y(3:4, 1) - Phi(y(1:2, 1), c) + tau(t).';
end