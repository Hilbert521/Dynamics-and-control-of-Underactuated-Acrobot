%% Defining constants
g = 9.8;
m1 = 1;
m2 = m1;
l1 = 1;
l2 = 2;
r1 = 1/2;
r2 = 1/2;
% q2_des = [pi/2 0];
gain = 1;
Kp = 16*gain;
Ki = 0*gain;
Kd = 8*gain;
alpha0 = -pi/4.5;
control_inputs = {Kp, Ki, Kd, alpha0};
K = [-245.9821  -98.4906 -106.2845  -50.0736];
constants = {g, m1, m2, l1, l2, r1, r2};
dev = [-90, 5]*(pi/180);     % initial deviation


%% Setting ode options
% opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
opts = odeset();


%% Solving ode
tspan = [0 30];
y0 = [dev(1, 2)-2*alpha0*atan(0)/pi; 0; dev(1, 1); 0];
global flag t_switch
% tau = zeros(0,0);
t_switch = 0;
flag = 1;
[t, y] = ode45(@(t,y) odefun(t, y, constants, control_inputs, K), tspan, y0, opts);


%% Calculating Angular accelerations, Power and Total Energy
y(t<=t_switch, 1) = y(t<=t_switch, 1) + 2*alpha0*atan(y(t<=t_switch, 4))/pi;
y = [y(:, 3) y(:, 1), y(:, 4) y(:, 2)];
torque = [zeros(size(t)) tau(t, y, constants, control_inputs, K)];
pow_by_tau = torque(:, 1) .* y(:, 3) + torque(:, 2) .* y(:, 4);     % [n, 1]
pow_by_energy = KE_dot(t, y, constants, torque) + PE_dot(y, constants);     % [n, 1]
TE = KE(y, constants) + PE(y(:, 1:2), constants);       % [n, 1]


%% Plotting graphs
close all;
set(0,'DefaultFigureWindowStyle','docked');
% y1, y2, y3, y4 vs time 
figure(1)
plot(t, y(:, 1:4));
title('State variables vs time')
legend('q1', 'q2', 'q1_dot', 'q2_dot', 'Interpreter', 'none', 'Location', 'southwest');
saveas(gcf, 'q_vs_t.png');
savefig(gcf, 'q_vs_t.fig');

% power vs time
figure(5)
hold on
plot(t, pow_by_tau);
plot(t, pow_by_energy);
title('Power vs time')
legend('pow_by_tau', 'pow_by_energy', 'Interpreter', 'none');
hold off
saveas(gcf, 'power_vs_t.png');
savefig(gcf, 'power_vs_t.fig');

% diff in power vs time
figure(10)
plot(t, pow_by_tau-pow_by_energy);
title('Difference in Power by two methods vs time')
saveas(gcf, 'power_error_vs_t.png');
savefig(gcf, 'power_error_vs_t.fig');

% TE vs time
figure(15)
plot(t, TE);
title('Total Energy vs time')
saveas(gcf, 'TE_vs_t.png');
savefig(gcf, 'TE_vs_t.fig');



%% Video Animation
simulate(y(:, 1), y(:, 2), l1, l2);