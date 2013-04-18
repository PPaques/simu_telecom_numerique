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
% Attenuation
alpha_n = 0.5;
alpha_n = rand(1);% [nombre entre 0 et 1]
% facteur de délay sur le taux binaire 
% calculé aléatoirement dans les paramètres calculés (différent pour chaque
% canal) il faut qu'il y ait le meme nombre de facteurs que de valeur dans
% le tableau
canal_delay_fact = [0.01 0.2 0.4 0.1];  % [pourcentage, très petit]
canal_delay_fact = rand(1,[n,1]); %

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