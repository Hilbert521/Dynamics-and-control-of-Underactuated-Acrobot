function torque = tau(t, q_act, q_des, ci, c)
% t can be a float or matrix, anything
% q_act is 1x6 matrix, actual values of q1, q2, q1_dot, q2_dot, q1_int and q2_int.
% q_des is 1x2 matrix, desired values of q1 and q2.
% ci is 3-element cell array, {Kp Ki Kd}, control inputs.
% c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
% Kp, Ki, Kd are 1x2 matrices.

t = num2cell(c);
[g, m1, m2, l1, l2, r1, r2] = deal(t{:});
[Kp, Ki, Kd] = deal(ci{:});
% torque = [zeros(size(t)) zeros(size(t))];
% e = round(q_des - q_act(1, 1:2), 4)
e = q_des - q_act(1, 1:2)
% torque = Kp*e - Kd*q_act(1, 3:4);
torque = (Kp.*e + Ki.*q_act(1, 5:6) - Kd.*q_act(1, 3:4))*[abs(e(1,1))>=abs(e(1,2)) -(abs(e(1,1))>=abs(e(1,2))); -(abs(e(1,1))<abs(e(1,2))) abs(e(1,1))<abs(e(1,2))]
end