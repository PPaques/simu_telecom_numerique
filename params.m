%% Params : contient tous les parametres de simulation
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% general
% nombre de messages a envoyer
n = 3;      % [nombre]
m = 6;       % [bits utiles a envoyer]
sequence_pilote = [1 0 1 1]'; 

% debit binaire
R = 1000;      % [bits/secondes] 

%% emetteur
% nombre de ressources disponibles 
N=n;

% Parametres du FIR
alpha = 0.5;  % [nombre] Rolof
L=4;        % [nombre]

% Puissance voulue sur le cable 
P_t = 0.5;    % [Watt]

% Impedence caracteristique du cable
Z_c = 50;    % [Ohms]

% Facteur de surechantillonage pour les signaux continus
gamma = 10;  % [nombre]


%% canal
% Attenuation
alpha_n = 0.5;
alpha_n = rand(1);% [nombre entre 0 et 1]

% facteur de delay sur le taux binaire 
% calcule aleatoirement dans les parametres calcules (different pour chaque
% canal) il faut qu'il y ait le meme nombre de facteurs que de valeur dans
% le tableau. Le nombre doit etre compris entre 0 et beta*gamma car le nombre
% d’echantillons pour t_b est ce nombre
tau_n = [5 25 1 4];  % [pourcentage, tres petit]

% Rapport signal a bruit qui sera ajoute sur le canal
snr = 1;

%% Recepteur
% Parametre filtre entree pour le decoupage en frequence
recepteur_ripple= 0.5;   % [ dB ]
recepteur_ordre = 3;     % [number]
type_filtre = 'B';
resolution_adc = 2;      %bits

% prise de décision
recepteur_decision_high = 0.2;
recepteur_decision_low = -0.2;



% rapport Eb/N0
% non utilise => SNR Attention que le SNR est en DB
% R_Eb_under_N0 = 1;



