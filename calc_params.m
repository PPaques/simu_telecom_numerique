%% calc_params : Calculs de variables utiles a partir du fichier de paramètres
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% paramètres calculés
% période pour un bit
T_b = 1/R; % [s/bits]

%% emetteur
% Facteur de suréchantillonage du FIR
beta = 4*N-2;   % [nombre]
% Durée échantillon numérique
T_n = T_b / beta; 
% Durée d'un échantillon Analogique
T_a = T_n / gamma;

%% canal
% facteur de délay sur le taux binaire 
% calculé aléatoirement dans les paramètres calculés (différent pour chaque
% canal) il faut qu'il y ait le meme nombre de facteurs que de valeur dans
% le tableau. Le nombre doit être compris entre 0 et beta*gamma car le nombre
% d’échantillons pour t_b est ce nombre
tau_n = randi([0 beta*gamma],1,N);