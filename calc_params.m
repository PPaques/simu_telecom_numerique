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
% délai ajoutés aux signaux du canal
Tau_n = T_b *canal_delay_fact ; % [durée]   





