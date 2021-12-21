
clear all

load ('energy_triads_autism_ses1.mat');
load ('energy_triads_autism_ses2.mat');
load ('energy_triads_control_ses1.mat');
load ('energy_triads_control_ses2.mat');


u_autism_ses1 = reshape(u_d_autism_ses1, [1,116*116*116]);
u_autism_ses1 = nonzeros(u_autism_ses1);

u_autism_ses2 = reshape(u_d_autism_ses2, [1,116*116*116]);
u_autism_ses2 = nonzeros(u_autism_ses2);

u_control_ses1 = reshape(u_d_control_ses1, [1,116*116*116]);
u_control_ses1 = nonzeros(u_control_ses1);

u_control_ses2 = reshape(u_d_control_ses2, [1,116*116*116]);
u_control_ses2 = nonzeros(u_control_ses2);


subplot(2,2,1);
y1 = linspace(0,1);
h1 = histogram(u_autism_ses1,200, 'normalization', 'probability');
ylim([0 1]);
ylabel ('Log( P (u) )');
set(gca,'YScale','log')
title('Autism Session 1');

subplot(2,2,2);
y2 = linspace(0,1);
h2 = histogram(u_autism_ses2,200, 'normalization', 'probability');
ylim([0 1]);
set(gca,'YScale','log');
title('Autism Session 2');


subplot(2,2,3);
y3 = linspace(0,1);
h3 = histogram(u_control_ses1, 200, 'normalization', 'probability');
ylim([0 1]);
set(gca,'YScale','log')
title('Control Session 1');


subplot(2,2,4);
y4 = linspace(0,1);
h4 = histogram(u_control_ses2, 200, 'normalization', 'probability');
ylim([0 1]);
set(gca,'YScale','log')
title('Control Session 2');
xlabel ('Energy (u)');

linkaxes([y1 y2 y3 y4],'xy')
suptitle('D: ( + - - ) Triads');

