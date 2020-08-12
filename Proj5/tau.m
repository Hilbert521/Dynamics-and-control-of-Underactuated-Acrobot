function torque = tau(t, q_act, q_des, ci, c)
% t can be a float or matrix, anything
% q_act is 1x6 matrix, actual values of q1, q2, q1_dot, q2_dot, q1_int and q2_int.
% q_des is 1x2 matrix, desired values of q1 and q2.
% ci is 3-element cell array, {Kp Ki Kd}, control inputs.
% c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
% Kp, Ki, Kd are 1x2 matrices.

% temp = num2cell(c);
% [g, m1, m2, l1, l2, r1, r2] = deal(temp{:});
[Kp, Ki, Kd, K] = deal(ci{:});
% torque = [zeros(size(t)) zeros(size(t))];
% e = round(q_des - q_act(1, 1:2), 4)
e = q_des - q_act(1, 1:2);
e*180/pi
% q_act
% torque = Kp*e - Kd*q_act(1, 3:4);
temp2 = -C(q_act(1, 1:4), c)*(q_act(1, 3:4).');
temp3 = -Phi(q_act(1, 1:2), c).';
torque = (Kp.*e + Ki.*q_act(1, 5:6) - Kd.*q_act(1, 3:4))*[1 -1; 0 0] + K*(temp2(2, 1)+temp3(2, 1))*[1 -1];
end