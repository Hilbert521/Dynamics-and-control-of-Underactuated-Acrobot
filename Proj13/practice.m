syms x y
% f = [x^2+y^2;x^3+y^3];
f = y*x^2+y^2;
flin = subs(f,{x, y}, {1, 2}) + (x-1)*subs(diff(f,x),1) + (y-2)*subs(diff(f,y),2);

fplot(subs(f,x,1),[0,10])
hold on
fplot(subs(flin,x,1),[1 3])
legend('F(y)','Flin(y)')