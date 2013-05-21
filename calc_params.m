%% calc_params : Calculs de variables utiles a partir du fichier de parametres
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% parametres calcules
% periode pour un bit
T_b = 1/R; % [s/bits]
% pour bien envoyer le bon nombre effectif de bits
m=m+length(sequence_pilote); 
% nombre de bits transmis
nb_bits_transmis = n*m;


%% emetteur
% Facteur de surechantillonage du FIR
beta = 4*N-2;   % [nombre]
% Duree echantillon numerique
T_n = T_b / beta; 
% Duree d'un echantillon Analogique
T_a = T_n / gamma;

%% canal
% facteur de delay sur le taux binaire 
% calcule aleatoirement dans les parametres calcules (different pour chaque
% canal) il faut qu'il y ait le meme nombre de facteurs que de valeur dans
% le tableau. Le nombre doit etre compris entre 0 et beta*gamma car le nombre
% d’echantillons pour t_b est ce nombre
if exist('bonus_mode')
    tau_n = randi([0 beta*gamma],1,N);
end
%% recepteur
%bande passante pour chaque fr�quence
b_pass = (1+alpha)/(2*T_b); 
Fa = 1/((T_b/beta)/gamma); 

%frequences a calculer
l_dac = beta*(m+2*L)*gamma;

