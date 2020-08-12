%% Defining constants
g = 9.81;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
r1 = 0.5;
r2 = 0.5;
q_des = [pi/2 0];
Kp = [80 80]*10000;
Ki = [25 25]*1000;
Kd = [2 2]*10000;
control_inputs = {Kp, Ki, Kd};
constants = [g, m1, m2, l1, l2, r1, r2];
dev = [-10, 5]*(pi/180);     % initial deviation


%% Setting ode options
% opts = odeset('Mass', @(~, y) [[1 0 0 0 0 0; 0 1 0 0 0 0]; ...
%                                [0 0; 0 0] D(y(1:2, 1).', constants) [0 0; 0 0]; ...
%                                [0 0 0 0 1 0; 0 0 0 0 0 1]], 'RelTol',1e-8,'AbsTol',1e-10);
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);


%% Solving ode
tspan = [0 0.02];
% y0 = zeros(1,4);
y0 = [pi/2+dev(1, 1); dev(1, 2); 0; 0; 0; 0];
[t, y] = ode45(@(t,y) odefun(t, y, constants, q_des, control_inputs), tspan, y0, opts);


%% Plotting graphs
close all;
set(0,'DefaultFigureWindowStyle','docked');
% q1, q2 vs time 
figure(4)
plot(t, y(:, 1:6))
legend('q1', 'q2', 'q1_dot', 'q2_dot', 'q1_int', 'q2_int', 'Interpreter', 'none');
% plot(t, y(:, 1:2));
% legend('q1', 'q2');
% F = getframe(gcf);
% figure(5)
% imshow(frame2im(F));