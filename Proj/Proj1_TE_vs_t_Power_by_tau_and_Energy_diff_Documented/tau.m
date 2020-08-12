function torque = tau(t)
% t can be a float or matrix, anything
% y = [q1 q2 q3 q4], q3 = q1_dot and q4 = q2_dot

% t = num2cell(c);
% [g, m1, m2, l1, l2, r1, r2] = deal(t{:});
% torque = [0 m2*l2*r2*g*cos(y(1, 1))];

% torque = [zeros(size(t)) zeros(size(t))];
torque = [sin(t) cos(t)];
end