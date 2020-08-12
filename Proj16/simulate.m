function simulate(t, y, c)

    [g, m1, m2, l1, l2, r1, r2] = deal(c{:});
    global tau2
    q1 = y(:, 1);
    q1_dot = y(:, 3);
    q2 = y(:, 2);
    q2_dot = y(:, 4);
    x1=l1*cos(q1); 
    y1=l1*sin(q1);
    x2=l2*cos(q1+q2)+l1*cos(q1);  
    y2=l2*sin(q1+q2)+l1*sin(q1);
    torque2 = interp1(tau2(:, 1), tau2(:, 2), t);

    stp = 1;    % steps taken in each iteration.
    % frac = 0.001;   % frac of length of q1, q2 to be written in video.
    % dur = uint64(uint64(size(q1, 1)*frac)/stp)*stp;     % duration of video, size of frameArr.
    dur = min(size(q1, 1), 990);      % WARNING: should be multiple of stp if following line is uncommented. And don't put it more than 998 Out of memory error will show up.
    % frameArr = zeros(dur/stp);  % will throw error later: "Conversion to double from struct is not possible".

    figure(100);
    for i=1:stp:dur
        subplot(2, 2, 3);
        grid on
        plot(t, y(:, 1:2)*(180/pi), t(i), y(i, 1:2)*(180/pi), '.', 'MarkerEdgeColor','k', 'MarkerSize',15);
        title('State variables(q1, q2) vs time')
        legend('q1', 'q2', 'Location', 'best');
        ylabel('Degrees')
        xlabel('s')
        subplot(2, 2, 4);
        grid off
        plot(t, y(:, 3:4)*(180/pi), t(i), y(i, 3:4)*(180/pi), '.', 'MarkerEdgeColor','k', 'MarkerSize',15);
        title('State variables(q1_dot, q2_dot) vs time', 'Interpreter', 'none')
        legend('q1_dot', 'q2_dot', 'Interpreter', 'none', 'Location', 'best');
        ylabel('Degrees/s')
        xlabel('s')
        
        hold off
        subplot(2, 2, 2);
        grid on
%         tau2(:, 1)==t(i)
%         try
%             plot(tau2(:, 1), [zeros(size(tau2(:, 1))) tau2(:, 2)], t(i), tau2(tau2(:, 1)==t(i), 2), '.', 'MarkerEdgeColor','k', 'MarkerSize',15)
%         catch
%             plot(tau2(:, 1), [zeros(size(tau2(:, 1))) tau2(:, 2)])
%         end
        plot(t, [zeros(size(t)) torque2], t(i), torque2(i, 1), '.', 'MarkerEdgeColor','k', 'MarkerSize',15)
        title('Torque vs time')
        legend('tau1', 'tau2', 'Location', 'best');
        ylabel('Nm')
        xlabel('s')
        subplot(2, 2, 1);
        cla
        hold on
        grid on
        plot([0 x1(i)],[0 y1(i)],'-r', 'LineWidth', m1);
        plot([x1(i) x2(i)], [y1(i) y2(i)],'-b', 'LineWidth', m2);
        plot([0 x1(i)],[0 y1(i)],'ok');
        plot(l1*r1*cos(q1(i)),l1*r1*sin(q1(i)),'.k',  'MarkerSize', m1*10);
        plot(l1*cos(q1(i)) + l2*r2*cos(q1(i)+q2(i)), l1*sin(q1(i)) + l2*r2*sin(q1(i)+q2(i)),'.k',  'MarkerSize', m2*10);
        hold off
    %     plot([0 x1(i) x2(i)],[0 y1(i) y2(i)],'k', 'o');
        xlabel('x')
        ylabel('y')
        ax_size = l1+l2;
        axis([-1 1 -1 1]*ax_size);  
        pbaspect([1 1 1]);     
        hold on   
        frameArr(i)=getframe(figure(100)); 
%         frameArr(i).cdata = frameArr(i).cdata(end :-1: 1, :, :);
%         s = size(frameArr(i).cdata);
%         fprintf('%d %d\n', s(2), s(1))
    end
    drawnow; %% exporting to 
    % Anmt=mpgwrite(MM,'RGB','trajectory.mpg');
    v = VideoWriter('simulation_new.avi');
    open(v);
    writeVideo(v, frameArr(2:end));
    close(v);
end