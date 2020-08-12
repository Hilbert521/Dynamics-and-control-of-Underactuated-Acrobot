function dydt = odefun2(t, y)
    % y = [q1; q2; q3; q4]
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % q_des is 1x2 matrix, desired values of q2 and q2_dot
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
    %           q3 = q1_dot and q4 = q2_dot

    A = [         0         0    1.0000         0; ...
         0         0         0    1.0000; ...
   10.4071   -5.6198         0         0; ...
  -11.4478   32.0538         0         0];
    B = [0         0   -1.2106    5.5717].';
    K = [-601.2717 -102.1865 -212.9274  -42.9091];

    dydt = (A - B*K)*y;
    y
end