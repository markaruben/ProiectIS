clear all; close all;
num = [-10 30];
den = [1 10 29];
H = tf(num,den)
%nyquist(H)

Te = 1/50;
Hd = c2d(H,Te,'tustin')
%rlocus(Hd)

A = [0 1;-29 -10];
B = [-10 ;130];
C = [1 0];
D = 0;

[num1,den1] = ss2tf(A,B,C,D);
Hnou = tf(num1,den1)
H
