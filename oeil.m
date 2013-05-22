%% Bonus : Diagramme de l'oeil
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Bonus 1 : Le diagramme de l'oeil
% Qu'est ce que c'est ? : 
%       Il permet d'evaluer qualitativement la qualite de transmission
%       numerique lordqu'il y a de l'interference entre symbole.
% C'est la syperposition de toutes les realisations possibles du signal
% recu dans un interval bien determine autour de l'instant
% d'echantillonnage T0. (pris par l'algo de synchro)

% Ex : [T0 - t_b; T0+ t_b]
%  L'ouverture de l'oeil donne la mesure de la qualite de transmission

% A faire : 
%    - Afficher le diagramme de l'oeil a la sortie du filtre adpate pour un
%        canal parfait (pas de bruit ni decalage analogique)
%    - Etudier l'influance du facteur alpha et de la longueur 2LTb du FIR
%        analogique sans bruit.
%    - On observe ensuite l'influance bruit, du filtrage analogique, et
%        enfin de l'interference provenantdes autres canaux
% 

%% on fait le diagramme de l'oeil dans le cadre d'un canal parfait 
% nettoyage
clear all;
close all;
bonus_mode = 'oeil';


%% cas emetteur parfait avec alpha = 1 et L = 4
clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha=1; alpha_n = 1; snr = 99;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
calc_params; emetteur;canal;recepteur;
bonus_oeil_parfait = signal_FA(:,1);
eyediagram(bonus_oeil_parfait,beta,T_b,2)
title('Diagramme oeil avec un canal parfait')
axis([-5*10^-4 5*10^-4 -3 3])


%% étude de la longueur
clearvars -except bonus*;
params;  n=2; N=n; m=50;alpha = 0.5; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
L=1;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_low = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_low,beta,T_b,1)
title('Diagramme oeil avec L = 1 ')
axis([-5*10^-4 5*10^-4 -3 3])


clearvars -except bonus*;
params;  n=2; N=n; m=50;alpha = 0.5; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
L=4;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_low = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_low,beta,T_b,1)
title('Diagramme oeil avec L = 4')
axis([-5*10^-4 5*10^-4 -3 3])


clearvars -except bonus*;
params;  n=2; N=n; m=50;alpha = 0.5; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
L=15;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_low = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_low,beta,T_b,1)
title('Diagramme oeil avec L = 15 ')
axis([-5*10^-4 5*10^-4 -3 3])

%% dans le cas d'une modification de la longueur de alpha
% initialisation de notre systeme de transmission
clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 0.2;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_low = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_low,beta,T_b,1)
title('Diagramme oeil avec alpha = 0.2 ')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 0.5;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_middle = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_middle,beta,T_b,1)
title('Diagramme oeil avec alpha = 0.5 ')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 1; 
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_high = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_high,beta,T_b,1)
title('Diagramme oeil avec alpha = 1 ')
axis([-5*10^-4 5*10^-4 -3 3])


%% Etude influance bruit
clearvars -except bonus*;
params; n=2; N=n; m=50; L=4; alpha_n = 1; recepteur_ordre = 1; alpha=0.5; 
alpha=0.4;
snr= 2;
calc_params;
tau_n = randi([0 beta*gamma],1,N);
emetteur;canal;recepteur;
bonus_oeil_bruit = signal_FA(:,1);
eyediagram(bonus_oeil_bruit,beta,T_b,1)
title('Diagramme oeil avec du bruit SNR =1')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params; n=2; N=n; m=50; L=4; alpha_n = 1; recepteur_ordre = 1; alpha=0.5; 
alpha=0.4;
snr= 1;
tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
calc_params;emetteur;canal;recepteur;
bonus_oeil_bruit = signal_FA(:,1);
eyediagram(bonus_oeil_bruit,beta,T_b,1)
title('Diagramme oeil avec du bruit SNR =1 et retards')
axis([-5*10^-4 5*10^-4 -3 3])


%% etudue filtrage analogique
clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 1;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_low = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_low,beta,T_b,1)
title('Diagramme oeil filtrage du recepteur ordre = 1')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 4;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_middle = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_middle,beta,T_b,3)
title('Diagramme oeil filtrage du recepteur ordre = 4')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params;  n=2; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 12;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_high = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_high,beta,T_b,1)
title('Diagramme oeil filtrage du recepteur ordre = 12')
axis([-5*10^-4 5*10^-4 -3 3])


%% interference autres cannaux 
clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
n=2;  N=n;
calc_params;emetteur;canal;recepteur;
bonus_oeil_interference_no = signal_FA(:,1);
eyediagram(bonus_oeil_interference_no,beta,T_b,2)
title('Diagramme oeil : 2 cannaux')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
n=5;  N=n;
calc_params;emetteur;canal;recepteur;
bonus_oeil_interference_middle = signal_FA(:,1);
eyediagram(bonus_oeil_interference_middle,beta,T_b,5)
title('Diagramme oeil : interferences 5 cannaux')
axis([-5*10^-4 5*10^-4 -3 3])

clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=0.5;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
n=12;  N=n;
calc_params; emetteur;canal;recepteur;
bonus_oeil_interference_high = signal_FA(:,1);
eyediagram(bonus_oeil_interference_high,beta,T_b,20)
title('Diagramme oeil : interferences 12 cannaux')
