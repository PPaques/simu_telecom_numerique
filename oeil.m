%% Bonus : Diagramme de l'oeil
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Bonus 1 : Le diagramme de l'oeil
% Qu'est ce que c'est ? : 
%       Il permet d'evaluer qualitativement la qualite de transmission
%       numerique lordqu'il y a de l'interference entre symbole.
% C'est la syperposition de toutes les realisations possibles du signal
% reçu dans un interval bien determine autour de l'instant
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
params;  n=1; N=1; m=50; L=4; alpha=1; alpha_n = 1; snr = 99;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
calc_params; emetteur;canal;recepteur;
bonus_oeil_parfait = signal_FA(:,1);

% parfait
eyediagram(bonus_oeil_parfait,beta,T_b,1)
title('Diagramme oeil avec un canal parfait')



%% dans le cas d'une modification de la longueur de alpha
% initialisation de notre systeme de transmission
clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 0.2;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_low = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_low,beta,T_b,1)
title('Diagramme oeil avec alpha = 0.2 ')


clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 0.5;
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_middle = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_middle,beta,T_b,1)
title('Diagramme oeil avec alpha = 0.5 ')


clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha = 0.8; 
calc_params;emetteur;canal;recepteur;
bonus_oeil_alpha_high = signal_FA(:,1);
eyediagram(bonus_oeil_alpha_high,beta,T_b,1)
title('Diagramme oeil avec alpha = 0.8 ')




%% Etude influance bruit
clearvars -except bonus*;
params; n=1; N=n; m=50; L=4; alpha_n = 1; snr = 2; recepteur_ordre = 1; alpha=0.5; tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
alpha=0.4;
snr= 2;
calc_params;emetteur;canal;recepteur;
bonus_oeil_bruit = signal_FA(:,1);
eyediagram(bonus_oeil_bruit,beta,T_b,1)
title('Diagramme oeil avec du bruit')


%% étudue filtrage analogique
clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 1;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_low = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_low,beta,T_b,1)
title('Diagramme oeil filtrage du recepteur ordre = 1')


clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 4;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_middle = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_middle,beta,T_b,1)
title('Diagramme oeil filtrage du recepteur ordre = 4')


clearvars -except bonus*;
params;  n=1; N=n; m=50; L=4; alpha_n = 1; snr = 99; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
recepteur_ordre = 8;
calc_params;emetteur;canal;recepteur;
bonus_oeil_filtrage_order_high = signal_FA(:,1);
eyediagram(bonus_oeil_filtrage_order_high,beta,T_b,1)
title('Diagramme oeil filtrage du recepteur ordre = 8')



%% interférence autres cannaux 
clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
n=1;  N=n;
calc_params;emetteur;canal;recepteur;
bonus_oeil_interference_no = signal_FA(:,1);
eyediagram(bonus_oeil_interference_no,beta,T_b,1)
title('Diagramme oeil : pas interferences')

clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
n=3;  N=n;
calc_params;emetteur;canal;recepteur;
bonus_oeil_interference_middle = signal_FA(:,1);
eyediagram(bonus_oeil_interference_middle,beta,T_b,1)
title('Diagramme oeil : interferences 3 cannaux')


clearvars -except bonus*;
params; L=4; alpha_n = 1; snr = 99; recepteur_ordre = 3; alpha=1;tau_n = [0 0 0 0 0 0 0 0 0 0 0 0];
n=10;  N=n;
calc_params; emetteur;canal;recepteur;
bonus_oeil_interference_high = signal_FA(:,1);
eyediagram(bonus_oeil_interference_middle,beta,T_b,1)
title('Diagramme oeil : interferences 10 cannaux')
