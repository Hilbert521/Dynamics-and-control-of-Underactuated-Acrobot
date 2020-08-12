function sim(q1,q2, l1, l2)

x1=l1*cos(q1); 
y1=l1*sin(q1);
x2=l2*cos(q1+q2)+l1*cos(q1);  
y2=l2*sin(q1+q2)+l1*sin(q1);

stp = 1;    % steps taken in each iteration.
% frac = 0.001;   % frac of length of q1, q2 to be written in video.
% dur = uint64(uint64(size(q1, 1)*frac)/stp)*stp;     % duration of video, size of frameArr.
dur = 990;      % WARNING: should be multiple of stp if following line is uncommented. And don't put it more than 998 Out of memory error will show up.
% frameArr = zeros(dur/stp);  % will throw error later: "Conversion to double from struct is not possible".

figure(10);
for i=1:stp:dur
    hold off     
    plot([x1(i) x2(i)],[y1(i) y2(i)],'o',[0 x1(i)],[0 y1(i)],'k',[x1(i) x2(i)],[y1(i) y2(i)],'k');
%     plot([0 x1(i) x2(i)],[0 y1(i) y2(i)],'k', 'o');
    xlabel('x')    
    ylabel('y')     
    axis([-2 2 -2 2]);  
    pbaspect([1 1 1]);
    grid     
    hold on   
    frameArr(i)=getframe(gcf); 
end
drawnow; %% exporting to 
% Anmt=mpgwrite(MM,'RGB','trajectory.mpg');
v = VideoWriter('simulation4.avi');
open(v);
writeVideo(v, frameArr);
close(v);
end