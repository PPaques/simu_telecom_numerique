%% Emetteur : Calcul des signaux de l'emetteur
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013


%% generateur de bits aleatoires a transmettre
% genere un message de n colones chacunes de m bits
message = round(rand(m-size(sequence_pilote,1),n));
% on ajoute la sequence pilote dans le systeme
sequence_pilote_n_message = repmat(sequence_pilote,1,n);
message = [sequence_pilote_n_message; message ];

message_ech_temps = 0 : T_b : (size(message,1)-1)*T_b;

%% codeur PAMtitle('Message a transmettre');
% transforme les bits en pam
message_pam = message.*2.-1;
message_pam_ech_temps = 0 : T_b : (size(message_pam,1)-1)*T_b;

%% ajout des zeros pour le surechantillonage
message_surech_pam = upsample(message_pam,beta);
message_surech_pam_ech_temps = 0 : T_b/beta : (size(message_surech_pam,1)-1)*T_b/beta;


%% creation d'un FIR en racine de nyquist
% calcul de coefficient des N FIR

% Facteur roloff, taille, facteur surechantillonnage, temps pour un bit le tout en racine de niquyst  
filtreg_t = rcosfir(alpha,L,beta,T_b,'sqrt')';

%% distribution du filtre de nyquist
% nombre de canneaux
n_can = 1:N-1; 
% base de temps (voit P3, en dessous eq 5 )
t = (-L*T_b:T_n:L*T_b)'; 
% Liste des frequences sur lesquelles on va emettre
W_n = (2*pi*2/T_b) .* n_can;

% Forme d'un symbole sur base du filtre pour chacun des canaux
p_n = [filtreg_t (filtreg_t*ones(1, N-1)).*cos(t*W_n)]; % on ajoute la freq 0 et les freq Wn
p_n_ech_freq = ((0:1:2*L*beta)-(L*beta))*R; % axe de frequences

%% convolution
% convoluer filtre avec message sur echantillon
% il faut faire une boucle avec des convolutions sur chaque colone

%initialising message_conv for performance issue (dynamic allocating
%deleted) La taille c'est facteur surech *2 L entre la longeur du filtre de Nyquist
message_conv = zeros(beta*(m+2*L),n);

% on ajoute des 0 si on a moins de messages que de canal dispo (en pratique
% on convoluera avec des 0 donc on ajoutera rien au signal mais cela permet
% de realiser la boucle de convolution
%message_surech_pam = [message_surech_pam zeros(m*beta,N)];


% on envoie chaque message sur un canal 
for i=1:N
    message_conv(:,i) = conv(message_surech_pam(:,i), p_n(:,i));
end


%% interpolation
% on va simuler le passage du message dans des DAC pour faire croire au
% systeme qu'on est dans du continu. (minimum un facteur 10 car on est oblige de rester en discret dans la simulation)

% on interpole sure une longueur egale au nombre d'echantillons fois le
% gamma
message_interpol = interpft(message_conv,beta*(m+2*L)*gamma);
% echelles pour le graphiques
x  = 0:T_n:(beta*(m+2*L)-1)*T_n;        % echelle numetique de temps           
xi = 0:T_a:(beta*(m+2*L)*gamma-1)*T_a;  % echelle analogique de temps

% on voit bien que le message est "mis en mode continu"
% Attenion : graphes a refaire en plus beau avec de belles couleurs et
% toussa quoi sinon on rivalisera pas avec l'ami seb!!!

%% Remise au facteur d'echelle
% Pour que l'emetteur emette a la puissance demandee, il faut le multiplier
% par le facteur kivabien et toutyramieux

% puissance = U^2/R
% U = srt(P*R)
%emetteur_final = message_interpol;
emetteur_final = message_interpol.*sqrt(Z_c*P_t);