%% Canal : Contient le canal d'une chaine de communication
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

% Canal idéal : 
%     * décalage temporel
%     * attenuation ne tenant pas compte de la fréquence
%     * bruit blanc AWGN ne tenant pas compte de la freq


%% Décalage dans le temps
% décalage dans le temps choisis aléatoirement pour chaque signal

% on fait un vecteur de décalement de la taille de la matrice
canal_retard_zero = [ emetteur_final ; zeros(beta*gamma, N) ];
%utilis� pour les graphique
canal_delay = canal_retard_zero;
% nouvelle echelle de temps, on ajouter beta*gamma echantillons
canal_retard_zero_ech_temps = 0:T_a:(((beta*(m+2*L)*gamma)+(beta*gamma))-1)*T_a; 

for i = 1:N
	canal_delay(:,i) = circshift(canal_delay(:,i),tau_n(i));
end

canal_time = canal_delay;

%% Ajout d'un facteur d'attenuation
% choisis de façon aléatoire mais identique pour tous les cannaux
% le facteur est le meme pour tous les canaux 
canal_att = canal_time * alpha_n;
canal_att_bruit = awgn(canal_att, snr);%utilise pour les graphiques


%% sommation sur le canal
% une fois sur le canal physique, les composante de chaque frequence sont
% additionnees aux autres. On se retrouve avec une matrice de 1 colonne
% avec N lignes. C'est le message qui transiste effectivement sur le canal.
% On filtre ce signal pour supprimer les composantes supperieures a la plus
% haute frequence
canal_sum = sum(canal_att')';


%% ajout d'un bruit blanc à ce signal.
% il faut calculer un bruit blan que l'on va ajouter au signal
% il sera de densité spectrale bilatérale N_0 /2

% bruit blanc AWGN... il existe la fonction
canal_final = awgn(canal_sum, snr);
%canal_final = canal_sum + snr * randn(size(canal_sum));

% je crois que randn permet de générer des distributions de sigma, il reste
% a mettre le facteur que je trouve pas dans la formule ci dessus