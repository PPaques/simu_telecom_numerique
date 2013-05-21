%% Params : contient tous les paramètres de simulation
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% général
% nombre de messages à envoyer
n = 3';      % [nombre]
m = 6;       % [bits utiles a envoyer]
sequence_pilote = [1 0 1 1]'; 

% debit binaire
R = 1000;      % [bits/secondes] 

%% emetteur
% nombre de ressources disponibles 
N=n;

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
% le tableau. Le nombre doit être compris entre 0 et beta*gamma car le nombre
% d’échantillons pour t_b est ce nombre
tau_n = [5 25 1 4];  % [pourcentage, très petit]

% Rapport signal a bruit qui sera ajouté sur le canal
snr = 1;

%% Récepteur
% Paramètre filtre entrée pour le découpage en fréquence
recepteur_ripple= 0.5;   % [ dB ]
recepteur_ordre = 3;     % [number]
type_filtre = 'B';
resolution_adc = 5;      %bits


% rapport Eb/N0
% non utilisé => SNR Attention que le SNR est en DB
% R_Eb_under_N0 = 1;



