%30 Mehr 98
%Draw P (log(U)) for each triad and each group

clear all

load('energy_triads_autism_ses1.mat');
load('energy_triads_control_ses1.mat');
load('energy_triads_autism_ses2.mat');
load('energy_triads_control_ses2.mat');

%control
% u_a_control_ses1 = reshape(u_a_control_ses1, [1,116*116*116]);
% u_a_control_ses1 = nonzeros(u_a_control_ses1);
% 
% u_c_control_ses1 = reshape(u_c_control_ses1, [1,116*116*116]);
% u_c_control_ses1 = nonzeros(u_c_control_ses1);
% 
% u_d_control_ses1 = reshape(u_d_control_ses1, [1,116*116*116]);
% u_d_control_ses1 = nonzeros(u_d_control_ses1);
% 
% u_a_control_ses2 = reshape(u_a_control_ses2, [1,116*116*116]);
% u_a_control_ses2 = nonzeros(u_a_control_ses2);
% 
% u_c_control_ses2 = reshape(u_c_control_ses2, [1,116*116*116]);
% u_c_control_ses2 = nonzeros(u_c_control_ses2);
% 
% u_d_control_ses2 = reshape(u_d_control_ses2, [1,116*116*116]);
% u_d_control_ses2 = nonzeros(u_d_control_ses2);
% 
% a_ses2 = histogram(u_a_control_ses2, 500, 'FaceColor','b','EdgeColor','b');
% set(gca, 'Yscale', 'log');
% hold on
% a_ses1 = histogram(u_a_control_ses1, 500, 'FaceColor','r','EdgeColor','r');
% set(gca, 'Yscale', 'log');
% hold on
% c_ses1 = histogram(u_c_control_ses1, 500, 'FaceColor','m','EdgeColor','m');
% set(gca, 'Yscale', 'log');
% hold on
% c_ses2 = histogram(u_c_control_ses2, 500, 'FaceColor','k','EdgeColor','k');
% set(gca, 'Yscale', 'log');
% hold on
% d_ses2 = histogram(u_d_control_ses2, 500, 'FaceColor','y','EdgeColor','y');
% set(gca, 'Yscale', 'log');
% hold on
% d_ses1 = histogram(u_d_control_ses1, 500, 'FaceColor','g','EdgeColor','g');
% set(gca, 'Yscale', 'log');
% 
% legend ([a_ses1 a_ses2 c_ses1 c_ses2 d_ses1 d_ses2],{'(+ + -) Session 1', '(+ + -) Session 2','(+ + +) Session 1', '(+ + +) Session 2','(+ - - ) Session 1', '(+ - - ) Session 2'});
% xlabel ('U');
% ylabel ('P ( Log (U) )');
% title ('Probability of triads for Control Group');

%autism
u_a_autism_ses1 = reshape(u_a_autism_ses1, [1,116*116*116]);
u_a_autism_ses1 = nonzeros(u_a_autism_ses1);

u_c_autism_ses1 = reshape(u_c_autism_ses1, [1,116*116*116]);
u_c_autism_ses1 = nonzeros(u_c_autism_ses1);

u_d_autism_ses1 = reshape(u_d_autism_ses1, [1,116*116*116]);
u_d_autism_ses1 = nonzeros(u_d_autism_ses1);

u_a_autism_ses2 = reshape(u_a_autism_ses2, [1,116*116*116]);
u_a_autism_ses2 = nonzeros(u_a_autism_ses2);

u_c_autism_ses2 = reshape(u_c_autism_ses2, [1,116*116*116]);
u_c_autism_ses2 = nonzeros(u_c_autism_ses2);

u_d_autism_ses2 = reshape(u_d_autism_ses2, [1,116*116*116]);
u_d_autism_ses2 = nonzeros(u_d_autism_ses2);

a_ses1 = histogram(u_a_autism_ses1, 500, 'FaceColor','r','EdgeColor','r');
set(gca, 'Yscale', 'log');
hold on
a_ses2 = histogram(u_a_autism_ses2, 500, 'FaceColor','b','EdgeColor','b');
set(gca, 'Yscale', 'log');
hold on
c_ses1 = histogram(u_c_autism_ses1, 500, 'FaceColor','m','EdgeColor','m');
set(gca, 'Yscale', 'log');
hold on
c_ses2 = histogram(u_c_autism_ses2, 500, 'FaceColor','k','EdgeColor','k');
set(gca, 'Yscale', 'log');
hold on
d_ses2 = histogram(u_d_autism_ses2, 500, 'FaceColor','y','EdgeColor','y');
set(gca, 'Yscale', 'log');
hold on
d_ses1 = histogram(u_d_autism_ses1, 500, 'FaceColor','g','EdgeColor','g');
set(gca, 'Yscale', 'log');

legend ([a_ses1 a_ses2 c_ses1 c_ses2 d_ses1 d_ses2],{'(+ + -) Session 1', '(+ + -) Session 2','(+ + +) Session 1', '(+ + +) Session 2','(+ - - ) Session 1', '(+ - - ) Session 2'});
xlabel ('U');
ylabel ('P ( Log (U) )');
title ('Probability of triads for Autism Group');

% A , C and D triads
% u_a_autism_ses2 = reshape(u_a_autism_ses2, [1,116*116*116]);
% u_a_autism_ses2 = nonzeros(u_a_autism_ses2);
% 
% u_c_autism_ses2 = reshape(u_c_autism_ses2, [1,116*116*116]);
% u_c_autism_ses2 = nonzeros(u_c_autism_ses2);
% 
% u_d_autism_ses2 = reshape(u_d_autism_ses2, [1,116*116*116]);
% u_d_autism_ses2 = nonzeros(u_d_autism_ses2);
% 
% u_a_control_ses2 = reshape(u_a_control_ses2, [1,116*116*116]);
% u_a_control_ses2 = nonzeros(u_a_control_ses2);
% 
% u_c_control_ses2 = reshape(u_c_control_ses2, [1,116*116*116]);
% u_c_control_ses2 = nonzeros(u_c_control_ses2);
% 
% u_d_control_ses2 = reshape(u_d_control_ses2, [1,116*116*116]);
% u_d_control_ses2 = nonzeros(u_d_control_ses2);
% 
% 
% %draw 
% figure
% 
% histogram(u_a_autism_ses2, 500, 'FaceColor','r','EdgeColor','r');
% set(gca, 'Yscale', 'log');
% hold on
% histogram(u_a_control_ses2, 500, 'FaceColor','b','EdgeColor','b');
% set(gca, 'Yscale', 'log');
% hold on
% 
% histogram(u_c_autism_ses2, 500, 'FaceColor','m','EdgeColor','m');
% set(gca, 'Yscale', 'log');
% hold on
% histogram(u_c_control_ses2, 500, 'FaceColor','k','EdgeColor','k');
% set(gca, 'Yscale', 'log');
% hold on
% 
% histogram(u_d_autism_ses2, 500, 'FaceColor','y','EdgeColor','y');
% set(gca, 'Yscale', 'log');
% hold on
% histogram(u_d_control_ses2, 500, 'FaceColor','g','EdgeColor','g');
% set(gca, 'Yscale', 'log');
% hold on
% 
% legend ('(+ + -) Autism', '(+ + -) Control','(+ + +) Autism', '(+ + +) Control','(+ - - ) Autism', '(+ - - ) Control');
% xlabel ('U');
% ylabel ('P ( Log (U) )');
% title ('Probability of triads in Session 2');


% B triads

% u_b_autism_ses1 = reshape(u_b_autism_ses1, [1,116*116*116]);
% u_b_autism_ses1 = nonzeros(u_b_autism_ses1);
% 
% u_b_control_ses1 = reshape(u_b_control_ses1, [1,116*116*116]);
% u_b_control_ses1 = nonzeros(u_b_control_ses1);
% 
% u_b_autism_ses2 = reshape(u_b_autism_ses2, [1,116*116*116]);
% u_b_autism_ses2 = nonzeros(u_b_autism_ses2);
% 
% u_b_control_ses2 = reshape(u_b_control_ses2, [1,116*116*116]);
% u_b_control_ses2 = nonzeros(u_b_control_ses2);
% 
% figure
% 
% control_ses2 = histogram(u_b_control_ses2, 600, 'FaceColor','b','EdgeColor','b');
% set(gca, 'Yscale', 'log');
% hold on
% control_ses1 = histogram(u_b_control_ses1, 600, 'FaceColor','c','EdgeColor','c');
% set(gca, 'Yscale', 'log');
% hold on
% autism_ses1 = histogram(u_b_autism_ses1, 600, 'FaceColor','k','EdgeColor','k');
% set(gca, 'Yscale', 'log');
% autism_ses2 = histogram(u_b_autism_ses2, 600, 'FaceColor','r','EdgeColor','r');
% set(gca, 'Yscale', 'log');
% 
% 
% legend ([autism_ses1 autism_ses2 control_ses1 control_ses2],{'(- - -) Autism Session 1', '(- - -) Autism Session 2','(- - -)  Control Session 1','(- - -) Control Session 2'});
% xlabel ('U');
% ylabel ('P ( Log (U) )');
% title ('Probability of (- - -) triad');

% C triads

% u_c_autism_ses1 = reshape(u_c_autism_ses1, [1,116*116*116]);
% u_c_autism_ses1 = nonzeros(u_c_autism_ses1);
% 
% u_c_control_ses1 = reshape(u_c_control_ses1, [1,116*116*116]);
% u_c_control_ses1 = nonzeros(u_c_control_ses1);
% 
% u_c_autism_ses2 = reshape(u_c_autism_ses2, [1,116*116*116]);
% u_c_autism_ses2 = nonzeros(u_c_autism_ses2);
% 
% u_c_control_ses2 = reshape(u_c_control_ses2, [1,116*116*116]);
% u_c_control_ses2 = nonzeros(u_c_control_ses2);
% 
% figure
% 
% autism_ses1 = histogram(u_c_autism_ses1, 600, 'FaceColor','k','EdgeColor','k');
% set(gca, 'Yscale', 'log');
% hold on
% autism_ses2 = histogram(u_c_autism_ses2, 600, 'FaceColor','r','EdgeColor','r');
% set(gca, 'Yscale', 'log');
% hold on
% control_ses1 = histogram(u_c_control_ses1, 600, 'FaceColor','c','EdgeColor','c');
% set(gca, 'Yscale', 'log');
% hold on
% control_ses2 = histogram(u_c_control_ses2, 600, 'FaceColor','b','EdgeColor','b');
% set(gca, 'Yscale', 'log');
% 
% legend ([autism_ses1 autism_ses2 control_ses1 control_ses2],{'(+ + +) Autism Session 1', '(+ + +) Autism Session 2','(+ + +) Control Session 1','(+ + +) Control Session 2'});
% xlabel ('U');
% ylabel ('P ( Log (U) )');
% title ('Probability of (+ + +) triad');

% D triads

% u_d_autism_ses1 = reshape(u_d_autism_ses1, [1,116*116*116]);
% u_d_autism_ses1 = nonzeros(u_d_autism_ses1);
% 
% u_d_control_ses1 = reshape(u_d_control_ses1, [1,116*116*116]);
% u_d_control_ses1 = nonzeros(u_d_control_ses1);
% 
% u_d_autism_ses2 = reshape(u_d_autism_ses2, [1,116*116*116]);
% u_d_autism_ses2 = nonzeros(u_d_autism_ses2);
% 
% u_d_control_ses2 = reshape(u_d_control_ses2, [1,116*116*116]);
% u_d_control_ses2 = nonzeros(u_d_control_ses2);
% 
% figure
% control_ses2 = histogram(u_d_control_ses2, 600, 'FaceColor','b','EdgeColor','b');
% set(gca, 'Yscale', 'log');
% hold on
% control_ses1 = histogram(u_d_control_ses1, 600, 'FaceColor','c','EdgeColor','c');
% set(gca, 'Yscale', 'log');
% hold on
% autism_ses2 = histogram(u_d_autism_ses2, 600, 'FaceColor','r','EdgeColor','r');
% set(gca, 'Yscale', 'log');
% hold on
% autism_ses1 = histogram(u_d_autism_ses1, 600, 'FaceColor','k','EdgeColor','k');
% set(gca, 'Yscale', 'log');
% 
% legend ([autism_ses1 autism_ses2 control_ses1 control_ses2],{'(+ - -) Autism Session 1', '(+ - -) Autism Session 2','(+ - -) Control Session 1','(+ - -) Control Session 2'});
% xlabel ('U');
% ylabel ('P ( Log (U) )');
% title ('Probability of (+ - -) triad');