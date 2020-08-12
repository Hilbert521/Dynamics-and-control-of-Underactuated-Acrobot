function dydt = odefun(t, y, c, q_des, ci)
% y = [q1; q2; q3; q4]
% c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
% q_des is 1x2 matrix, desired values of q1 and q2
% ci is 3-element cell array, {Kp Ki Kd}, control inputs.
% dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
%           q3 = q1_dot and q4 = q2_dot

dydt = zeros(6, 1);
dydt(1:2, 1) = [y(3, 1); y(4, 1)];
% dydt(3:4, 1) = -C(y.', c)*y(3:4, 1) - Phi(y(1:2, 1).', c).' + tau(t, y.', q_des, ci, c).';
dydt(3:4, 1) = D(y(1:2, 1).', c)\(-C(y.', c)*y(3:4, 1) - Phi(y(1:2, 1).', c).' + tau(t, y.', q_des, ci, c).');
dydt(5:6, 1) = [q_des(1, 1)-y(1, 1); q_des(1, 2)-y(2, 1)];
end