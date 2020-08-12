%% Defining constants
g = 9.81;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
r1 = 0.5;
r2 = 0.5;
constants = [g, m1, m2, l1, l2, r1, r2];
%%

%% Setting ode options
opts = odeset('Mass', @(~, y) [[1 0 0 0; 0 1 0 0]; ...
                               [0 0; 0 0] D(y(1:2, 1).', constants)], 'RelTol',1e-8,'AbsTol',1e-10);
%%

%% Solving ode
tspan = [0 20];
% y0 = zeros(1,4);
y0 = [0; 0; 0; 0];
[t, y] = ode45(@(t,y) odefun(t, y,constants), tspan, y0, opts);
%%

%% Calculating Angular accelerations, Power and Total Energy
% ang_acc = alpha(t, y, constants);   % [n, 2]
torque = tau(t);
pow_by_tau = torque(:, 1) .* y(:, 3) + torque(:, 2) .* y(:, 4);     % [n, 1]
pow_by_energy = KE_dot(t, y, constants) + PE_dot(y, constants);     % [n, 1]
TE = KE(y, constants) + PE(y(:, 1:2), constants);       % [n, 1]
%%

%% Plotting graphs
close all;
set(0,'DefaultFigureWindowStyle','docked');
% q1, q2 vs time 
figure(4)
plot(t, y(:, 1:2))
legend('q1', 'q2', 'Interpreter', 'none');
% power vs time
figure(1)
hold on
plot(t, pow_by_tau);
plot(t, pow_by_energy);
title('Power vs time')
legend('pow_by_tau', 'pow_by_energy', 'Interpreter', 'none');
hold off
% diff in power vs time
figure(2)
plot(t, pow_by_tau-pow_by_energy);
title('Difference in Power by two methods vs time')
% TE vs time
figure(3)
plot(t, TE);
title('Total Energy vs time')