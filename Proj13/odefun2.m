function dydt = odefun2(t, y, c, K)
    % y = [q1; q2; q3; q4]
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % q_des is 1x2 matrix, desired values of q2 and q2_dot
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
    %           q3 = q1_dot and q4 = q2_dot

%     A = [0         0    1.0000         0;
%          0         0         0    1.0000;
%    12.6000  -12.6000         0         0;
%   -14.7000   29.4000         0         0];
% 
%     B = [0 0 -3 6].';
%     K
%     dydt = (A - B*K)*y;
%     y
%     u = -K*x;
%         assert(size(u, 2) == 1)
%         if isempty(tau) || t>tau(end, 1)
%             tau = [tau; [t u]];
%         end


    [g, m1, m2, l1, l2, r1, r2] = deal(c{:});
    dydt = zeros(4, 1);

    u = -K*y;
    
    q1 = y(1, 1)+pi/2;
    q2 = y(2, 1);
    q1_dot = y(3, 1);
    q2_dot = y(4, 1);
    d11 = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(q2)) + Izz(m1, l1, r1) + Izz(m2, l2, r2);
    d12 = m2 * ((l2*r2)^2 + l1*l2*r2*cos(q2)) + Izz(m2, l2, r2);
    d21 = d12;
    d22 = m2 * (l2*r2)^2 + Izz(m2, l2, r2);
    h = -m2*l1*l2*r2*sin(q2);
    h1 = [h*q2_dot h*(q1_dot+q2_dot)]*[q1_dot;q2_dot];
    h2 = -h*q1_dot^2;
    phi1 = (m1*l1*r1 + m2*l1) * g * cos(q1) + m2*l2*r2*g * cos(q1+q2);
    phi2 = m2*l2*r2*g*cos(q1+q2);

    d2_bar = d22 - d12*d21/d11;
    h2_bar = h2 - d21*h1/d11;
    phi2_bar = phi2 - d21*phi1/d11;

    v2 = (u - h2_bar - phi2_bar)/d2_bar;

    dydt(1, 1) = y(3, 1);
    dydt(2, 1) = y(4, 1);
    dydt(3, 1) = -(h1+phi1+d12*v2)/d11;
    dydt(4, 1) = v2;
end