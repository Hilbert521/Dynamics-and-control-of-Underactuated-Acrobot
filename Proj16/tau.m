function torque = tau(t, y, c, ci, K)
    % t can be a float or matrix, anything
    % q_act is 1x6 matrix, actual values of q1, q2, q1_dot, q2_dot, q1_int and q2_int.
    % q_des is 1x2 matrix, desired values of q1 and q2.
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % Kp, Ki, Kd are 1x2 matrices.

    [g, m1, m2, l1, l2, r1, r2] = deal(c{:});
    [Kp, Ki, Kd, q2_des] = deal(ci{:});
    global t_switch
    
    q1 = y(:, 1);
    q1_dot = y(:, 3);
    q2 = y(:, 2);
    q2_dot = y(:, 4);

    d11 = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(q2)) + Izz(m1, l1, r1) + Izz(m2, l2, r2);
    d12 = m2 * ((l2*r2)^2 + l1*l2*r2*cos(q2)) + Izz(m2, l2, r2);
    d21 = d12;
    d22 = m2 * (l2*r2)^2 + Izz(m2, l2, r2);
    h = -m2*l1*l2*r2*sin(q2);
    h1 = 2*h.*q2_dot.*q1_dot + h.*(q2_dot.^2);
    h2 = -h.*q1_dot.^2;
    phi1 = (m1*l1*r1 + m2*l1) * g * cos(q1) + m2*l2*r2*g * cos(q1+q2);
    phi2 = m2*l2*r2*g*cos(q1+q2);

    d2_bar = d22 - d12.*d21./d11;
    h2_bar = h2 - d21.*h1./d11;
    phi2_bar = phi2 - d21.*phi1./d11;
    
%     torque = d12.*q1_ddot + d22.*q2_ddot + h2 + phi2;
    
    v2 = -Kp*(q2(t<t_switch, 1)-q2_des)-Kd*q2_dot(t<t_switch, 1);
    y(t>=t_switch, 1) = y(t>=t_switch, 1) - pi/2;
    torque = [v2.*d2_bar(t<t_switch, 1) + h2_bar(t<t_switch, 1) + phi2_bar(t<t_switch, 1); (-K*(y(t>=t_switch, :).')).'];
%     ind1 = y(:, 1)>=0;
%     ind2 = y(:, 1)<0;
%     y(ind1, 1) = y(ind1, 1) - pi/2;
%     y(ind2, 1) = y(ind2, 1) + 3*pi/2;
%     torque = [torque; (-K*(y(t>=t_switch, :).')).'];
end