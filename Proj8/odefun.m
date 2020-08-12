function dydt = odefun(t, y, c, ci)
    % y = [q1; q2; q3; q4]
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % q_des is 1x2 matrix, desired values of q2 and q2_dot
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
    %           q3 = q1_dot and q4 = q2_dot

    [g, m1, m2, l1, l2, r1, r2] = deal(c{:});
    [Kp, Ki, Kd, alpha] = deal(ci{:});
    dydt = zeros(4, 1);
    dev = 5;
%     flag = 1;
%     if 0
%     y(3, 1)
    global flag
%     if (y(3, 1)>(90-dev)/180*pi) && (y(3, 1)<(-270+dev)/180*pi) && ((y(1, 1)+2*alpha*atan(y(4, 1))/pi)>(-dev)/180*pi) && ((y(1, 1)+2*alpha*atan(y(4, 1))/pi)<(dev)/180*pi) && flag
    if (((y(3, 1)>(90-dev)/180*pi) || (y(3, 1)<(-270+dev)/180*pi)) && (abs(y(4, 1)) < 0.005)) || (flag==0)
        if flag == 1
            flag = 0;
            q1_dot = y(4, 1);
            q2_dot = y(2, 1);
            q2 = y(1, 1) + 2*alpha*atan(q1_dot)/pi;
            if y(3,1)>0
                q1 = y(3, 1)-pi/2;
            else
                q1 = y(3, 1)+3*pi/2;
            end
            x = [q1 q2 q1_dot q2_dot]
            y = x.';
        end
        A = [0      0    1     0; ...
             0      0    0     1; ...
             12.6 -12.6 0     0; ...
            -14.7  29.4 0     0];
        B = [0; 0; -3; 6];
        K = [-242.52 -96.33 -104.59 -49.05];

        dydt = (A - B*K)*y;
%         dydt = [dydt(2, 1); dydt(4, 1); dydt(1, 1); dydt(3, 1)];
    %     dydt = zeros(4, 1);
%         x
    else
        q1 = y(3, 1);
        q1_dot = y(4, 1);
        q2_des = 2*alpha*atan(q1_dot)/pi;
        q2 = y(1, 1) + q2_des;
        q2_dot = y(2, 1);

        d11 = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(q2)) + Izz(m1, l1) + Izz(m2, l2);
        d12 = m2 * ((l2*r2)^2 + l1*l2*r2*cos(q2)) + Izz(m2, l2);
        h = -m2*l1*l2*r2*sin(q2);
        h1 = [h*q2_dot h*(q1_dot+q2_dot)]*[q1_dot;q2_dot];
        phi1 = (m1*l1*r1 + m2*l1) * g * cos(q1) + m2*l2*r2*g * cos(q1+q2);

        dydt(1, 1) = y(2, 1);
        dydt(2, 1) = -Kp*y(1, 1) - Kd*y(2, 1);
        dydt(3, 1) = y(4, 1);
        dydt(4, 1) = -(h1+phi1)/d11 - d12*(-Kp*y(1, 1)-Kd*y(2, 1))/d11;

    %         q1
    %     q2
    end
end