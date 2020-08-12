%{

C
    Input-->   y- 1x4 matrix = [q1 q2 q1_dot q2_dot]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  c_mat- 2x2 matrix
    
    
D
    Input-->   y- 1x2 matrix = [q1 q2]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  inertia_mat- 2x2 matrix
    
    
Izz
    Input-->   m- float, mass of rod
               l- float, length of rod
    Output-->  I- float, moment of inertia about centre of mass
    
    
main
    Main file, run this file. Use tau.m to apply torque


odefun
    Input-->   t- no_time_stepsx1 matrix
               y- 4x1 matrix = [q1; q2; q3; q4;], q3 = q1_dot and q4 = q2_dot
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
               q_des- 1x2 matrix, desired values of q1 and q2, [q1_des q2_des]
    `          ci- 1x4 matrix = [Kp Ki Kd], control inputs
    Output-->  dydt- [q1_dot; q2_dot; q3_dot; q4_dot]
    
        
Phi
    Input-->   y- no_time_stepx2 matrix, y(i, :) = [q1i q2i]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  phi- 1x2 matrix, [dPE/dq1 dPE/dq2]
    
    
Readme
    Instructions file


sim
    Input-->   q1, q2- no_time_stepx1 matrices
               l1, l2- length of links.
	Writes to a video file saved to current folder
    
    
tau- torque  applied at 2 joints
    Input-->   t- can be a float or 1_D matrix
               q_act- 1x6 matrix, actual values of q1, q2, q1_dot, q2_dot, q1_int and q2_int.
               q_des- 1x2 matrix, desired values of q1 and q2
               ci- 3-element cell array = {Kp Ki Kd}, control inputs. Kp, Ki, Kd are 1x2 matrices
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  torque- _x2 matrix 
    
%}