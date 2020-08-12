%{

alpha
    Input-->   t- no_time_stepsx1 matrix
               y- no_time_stepsx4 matrix, y(i, :) = [q1i, q2i, q1_doti, q2_doti]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  q_ddot- no_time_stepsx2 matrix, q_ddot(i, :) = [q1_ddoti, q2_ddoti]


C
    Input-->   y- 1x4 matrix = [q1 q2 q1_dot q2_dot]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  c_mat- 2x2 matrix
    
    
D
    Input-->   y- 1x2 matrix = [q1 q2]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  inertia_mat- 2x2 matrix
    
    
D_dot
    Input-->   y- 1x4 matrix = [q1 q2 q1_dot q2_dot]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  c_mat- 2x2 matrix
    
    
Izz
    Input-->   m- float, mass of rod
               l- float, length of rod
    Output-->  I- float, moment of inertia about centre of mass
    
    
KE
    Input-->   y- no_time_stepx4 matrix, y(i, :) = [q1i q2i q1_doti q2_doti]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  k- no_time_stepx1 matrix
    
    
KE_dot
    Input-->   t- no_time_stepsx1 matrix
               y- no_time_stepx4 matrix, y(i, :) = [q1i q2i q1_doti q2_doti]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  kp- no_time_stepsx1 matrix
    
    
KE_dot2  % same output as KE_dot, solved differently, brute force, not smart
    Input-->   t- no_time_stepsx1 matrix
               y- no_time_stepx4 matrix, y(i, :) = [q1i q2i q1_doti q2_doti]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  kp- no_time_stepsx1 matrix
    

main
    Main file, run this file. Use tau.m to apply torque

    
odefun
    Input-->   t- no_time_stepsx1 matrix
               y- 4x1 matrix = [q1; q2; q3; q4;], q3 = q1_dot and q4 = q2_dot
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  dydt- [q1_dot; q2_dot; q3_dot; q4_dot]
    
    
PE
    Input-->   y- no_time_stepx2 matrix, y(i, :) = [q1i q2i]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  p- no_time_stepx1 matrix
    
    
PE_dot
    Input-->   y- no_time_stepx4 matrix, y(i, :) = [q1i q2i q1_doti q2_doti]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  pp- no_time_stepx1 matrix
    
    
Phi
    Input-->   y- no_time_stepx2 matrix, y(i, :) = [q1i q2i]
               c- row vector of constants ([g, m1, m2, l1, l2, r1, r2])
    Output-->  phi- 1x2 matrix, [dPE/dq1 dPE/dq2]
    
    
Readme
    Instructions file
    
    
tau- torque  applied at 2 joints
    Input-->   t- can be a float or 1_D matrix
    Output-->  torque- size(t)x2 matrix 
    
%}