%% Params : contient tous les paramètres de simulation
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% général
% nombre de messages à envoyer
n = 4';      % [nombre]
m = 8;       % [bits]
sequence_pilote = [1 0 1 1]'; 

% debit binaire
R = 1000;      % [bits/secondes] 

%% emetteur
% nombre de ressources disponibles 
N=4;

% Paramètres du FIR
alpha = 0.4;  % [nombre] Rolof
L=4;        % [nombre]

% Puissance voulue sur le cable 
P_t = 5;    % [Watt]

% Impédence caractéristique du cable
Z_c = 50;    % [Ohms]

% Facteur de suréchantillonage pour les signaux continus
gamma = 10;  % [nombre]


%% canal
% gain
alpha_n = 1;% [nombre]
% délais
Tau_n = 1;  % [s]

%% Récepteur
% rapport Eb/N0
R_Eb_under_N0 = 1;

% Paramètre filtre analogique
nature = 1;
ordre = 1 ;
ripple = 1;
attenuation = 1;

% seuil v pour récepteur simplifié
V = 0.75;