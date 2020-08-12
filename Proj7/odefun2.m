function dydt = odefun2(t, y, c, ci)
    % y = [q1; q2; q3; q4]
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % q_des is 1x2 matrix, desired values of q2 and q2_dot
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
    %           q3 = q1_dot and q4 = q2_dot

    x = y;
    A = [0      0    1     0; ...
         0      0    0     1; ...
         12.49 -12.54 0     0; ...
        -14.49  29.36 0     0];
    B = [0; 0; -2.98; 5.98];
    K = [-242.52 -96.33 -104.59 -49.05];

    dydt = (A - B*K)*x;
    x
end