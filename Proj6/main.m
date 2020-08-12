%% Defining constants
g = 9.81;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
r1 = 0.5;
r2 = 0.5;
% q2_des = [pi/2 0];
gain = 1;
Kp = 16*gain;
Ki = 0*gain;
Kd = 8*gain;
alpha = -pi/3;
control_inputs = {Kp, Ki, Kd, alpha};
constants = {g, m1, m2, l1, l2, r1, r2};
dev = [-90, 5]*(pi/180);     % initial deviation


%% Setting ode options
% opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
opts = odeset();


%% Solving ode
tspan = [0 20];
y0 = [dev(1, 2)-2*alpha*atan(0)/pi; 0; dev(1, 1); 0];
[t, y] = ode45(@(t,y) odefun(t, y, constants, control_inputs), tspan, y0, opts);


%% Plotting graphs
close all;
set(0,'DefaultFigureWindowStyle','docked');
% q1, q2 vs time 
figure(4)
plot(t, y(:, 1:4));
legend('z1', 'z2', 'eta1', 'eta2', 'Interpreter', 'none', 'Location', 'southwest');
% plot(t, y(:, 1:2));
% legend('q1', 'q2');
hold on;
saveas(gcf, 'graph.png');
savefig(gcf, 'graph.fig');


%% Video Animation
sim(y(:, 3), y(:, 1)+2*alpha*atan(y(:, 4))/pi, l1, l2);