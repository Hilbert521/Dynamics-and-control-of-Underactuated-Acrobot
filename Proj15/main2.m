%% Defining constants
g = 9.8;
m1 = 1;
m2 = 3*m1;
l1 = 1;
l2 = 1.5;
r1 = 1/1.5;
r2 = 1/5;

constants = {g, m1, m2, l1, l2, r1, r2};
K = linearize(constants);
dev = [-21.8279, 90]*(pi/180);     % initial deviation


%% Setting ode options
% opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
opts = odeset();


%% Solving ode
tspan = [0 10];
% y0 = [0.0585   -0.2267    0.2306    0.0000].';
y0 = [dev(1, 1); dev(1, 2); -9.5716e-04; 0];
[t, y] = ode45(@(t,y) odefun2(t, y, constants, K), tspan, y0, opts);


%% Plotting graphs
close all;
set(0,'DefaultFigureWindowStyle','docked');
% q1, q2 vs time 
figure(4)
% y(:, 1:2) = 180/pi*y(:, 1:2);
plot(t, y(:, 1:4)*180/pi);
legend('x1', 'x2', 'x3', 'x4', 'Interpreter', 'none', 'Location', 'southwest');
% plot(t, y(:, 1:2));
% legend('q1', 'q2');
hold on;
saveas(gcf, 'graph.png');
savefig(gcf, 'graph.fig');


%% Video Animation
% simulate(y(:, 3)+pi/2, y(:, 1), l1, l2);