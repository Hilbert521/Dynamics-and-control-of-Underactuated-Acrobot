function dydt = odefun(t, y, c, ci, K)
    % y = [q1; q2; q3; q4]
    % c is a row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    % q_des is 1x2 matrix, desired values of q2 and q2_dot
    % ci is 3-element cell array, {Kp Ki Kd}, control inputs.
    % dydt = [q1_dot; q2_dot; q3_dot; q4_dot]
    %           q3 = q1_dot and q4 = q2_dot

    [g, m1, m2, l1, l2, r1, r2] = deal(c{:});
    [Kp, Ki, Kd, alpha0] = deal(ci{:});
    dydt = zeros(4, 1);
    dev = 7;
    
    global flag t_switch
    if (((y(3, 1)>(90-dev)/180*pi && y(3, 1)<=pi/2) || (y(3, 1)<(-270+dev)/180*pi && y(3, 1)>=-3*pi/2))) || (flag==0)
        q1_dot = y(4, 1);
        q2_dot = y(2, 1);
        q1 = y(3, 1);
        assert(abs(sin(q1) - sin(y(3,1))) < 1e-10 && abs(cos(q1) - cos(y(3,1))) < 1e-10)
        if q1>=0
            q1 = q1 - pi/2;
        else
            q1 = q1 + 3*pi/2;
        end
        assert(q1 <= 3*pi/2 && q1 >=-pi/2)
        if flag == 1
            q2 = y(1, 1) + 2*alpha0*atan(q1_dot)/pi;
            t_switch = t;
            flag = 0;
            x = [q1; q2; q1_dot; q2_dot];
            x.'
        else
            q2 = y(1, 1);
            x = [q1; q2; q1_dot; q2_dot];
        end
        
        u = -K*x;
%         assert(size(u, 2) == 1)
%         if isempty(tau) || t>tau(end, 1)
%             tau = [tau; [t u]];
%         end
        
        q1 = y(3, 1);
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
    else
        q1 = y(3, 1);
        q1_dot = y(4, 1);
        q2_des = 2*alpha0*atan(q1_dot)/pi;
        q2 = y(1, 1) + q2_des;
        q2_dot = y(2, 1);
        
        d11 = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(q2)) + Izz(m1, l1, r1) + Izz(m2, l2, r2);
        d12 = m2 * ((l2*r2)^2 + l1*l2*r2*cos(q2)) + Izz(m2, l2, r2);
        h = -m2*l1*l2*r2*sin(q2);
        h1 = [h*q2_dot h*(q1_dot+q2_dot)]*[q1_dot;q2_dot];
        phi1 = (m1*l1*r1 + m2*l1) * g * cos(q1) + m2*l2*r2*g * cos(q1+q2);
        
        v2 = -Kp*y(1, 1)-Kd*y(2, 1);
    end
    
    dydt(1, 1) = y(2, 1);
    dydt(2, 1) = v2;
    dydt(3, 1) = y(4, 1);
    dydt(4, 1) = -(h1+phi1)/d11 - d12*v2/d11;
end