%% Pre-clean
clear
close all
clc


%% a)
a = 4:2:100;


%% b)
b = 5:-1:-5;


%% c)
c = linspace(0, 1);


%% d)
d_B = rand(20,30);
d_C = d_B(10:15, 9:12);


%% e)
e_x = -pi:pi/15:pi;


%% f)
plot(e_x, sin(4*pi*e_x))