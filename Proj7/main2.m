%% Defining constants
g = 9.81;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 2;
r1 = 0.5;
r2 = 0.5;
dev = [-15, 25]*(pi/180);     % initial deviation


%% Setting ode options
% opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
opts = odeset();


%% Solving ode
tspan = [0 20];
% y0 = [0.2477; 0.5868; -0.6563; 0];
y0 = [dev(1, 1); dev(1, 2); 0; 0];
[t, y] = ode45(@(t,y) odefun2(t, y, constants, control_inputs), tspan, y0, opts);


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
simulate(y(:, 3)+pi/2, y(:, 1), l1, l2);