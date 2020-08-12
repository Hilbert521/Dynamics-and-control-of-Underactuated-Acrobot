g = 9.81;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
r1 = 0.5;
r2 = 0.5;
constants = [g, m1, m2, l1, l2, r1, r2];
opts = odeset('Mass', @(~, y) [[1 0; 0 1] [0 0; 0 0]; [0 0; 0 0] D(y(1:2, 1), constants)], 'RelTol',1e-8,'AbsTol',1e-10);
tspan = [0 20];
% y0 = zeros(4,1);
y0 = [0; 0; 0; 0];
[t, y] = ode45(@(t,y) odefun(t, y,constants), tspan, y0, opts);
% ang_acc = alpha(t, y, constants);   % [n, 2]
torque = tau(t);
pow_by_tau = torque(:, 1) .* y(:, 3) + torque(:, 2) .* y(:, 4);     % [n, 1]
pow_by_energy = KE_dot(t, y, constants) + PE_dot(y, constants);     % [n, 1]
close all
figure(1)
hold on
plot(t, pow_by_tau);
plot(t, pow_by_energy);
legend('pow_by_tau', 'pow_by_energy')
hold off
figure(2)
plot(t, pow_by_tau-pow_by_energy);
% TE = KE(y, constants) + PE(y(:, 1:2), constants);
% close all;
% figure(1)
% plot(t, TE);
% figure(2)