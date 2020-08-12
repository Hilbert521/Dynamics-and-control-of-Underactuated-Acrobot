tspan = [0 5];
y0 = ones(2,1)*100;
opts = odeset('Mass', @M);
[t,y] = ode45(@f, tspan, y0, opts);
plot(t,y,'-o');