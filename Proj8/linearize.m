%% Defining constants
g = 9.8;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 2;
r1 = 0.5;
r2 = 0.5;


%% Linearizing
syms x1 x2 x3 x4 u
d11 = m1 * (l1*r1)^2 + m2 * (l1^2 + (l2*r2)^2 + 2*l1*l2*r2*cos(x3)) + Izz(m1, l1) + Izz(m2, l2);
d12 = m2 * ((l2*r2)^2 + l1*l2*r2*cos(x3)) + Izz(m2, l2);
d22 = m2 * (l2*r2)^2 + Izz(m2, l2);
d = [d11 d12; d12 d22];

mat1 = [1 1 0 0; ...
        0 0 1 1];
mat2 = [0; u];

h = -m2*l1*l2*r2*sin(x3);
h1 = [h*x4 h*(x2+x4)]*[x2;x4];
h2 = m2*l1*l2*r2*sin(x3)*(x2^2);
phi1 = -(m1*l1*r1 + m2*l1) * g * sin(x1) - m2*l2*r2*g * sin(x1+x3);
phi2 = -m2*l2*r2*g*sin(x1+x3);

f = -d\(mat1*[h1;phi1;h2;phi2]) + d\mat2;
flin = subs(f, {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0}) + x1*subs(diff(f,x1), {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0}) ...
                                                     + x2*subs(diff(f,x2), {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0}) ...
                                                     + x3*subs(diff(f,x3), {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0}) ...
                                                     + x4*subs(diff(f,x4), {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0}) ...
                                                     + u*subs(diff(f,u), {x1, x2, x3, x4, u}, {0, 0, 0, 0, 0});
A = [0      0    1     0; ...
     0      0    0     1; ...
     subs(flin, {x1, x3, u}, {1, 0, 0}) subs(flin, {x1, x3, u}, {0, 1, 0}) [0 0; 0 0]];
B = [0; 0; subs(flin, {x1, x3, u}, {0, 0, 1})];
A = double(A);
B = double(B);
% Q = [1000 -500 0 0; ...
%     -500 1000 0 0; ...
%     0 0 1000 -500; ...
%     0 0 -500 1000];
Q = eye(4);
R = 1;
[K, P, E] = lqr(A, B, Q, R);
                                                 