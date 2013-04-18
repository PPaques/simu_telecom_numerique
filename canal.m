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
canal_delay_fact_all = repmat(canal_delay_fact, size(emetteur_final,1),1);
% on soustrait ces valeurs à tous les échantillons
canal_time = emetteur_final - canal_delay_fact_all;



%% Ajout d'un facteur d'attenuation
% choisis de façon aléatoire mais identique pour tous les cannaux
% le facteur est le meme pour tous les canaux 
canal_att = canal_time * alpha_n;




%% sommation sur le canal
% une fois sur le canal physique, les composante de chaque fr�quence sont
% additionn�es aux autres. On se retrouve avec une matrice de 1 colonne
% avec N lignes. C'est le message qui transiste effectivement sur le canal.
% On filtre ce signal pour supprimer les composantes supp�rieures � la plus
% haute fr�quence
canal_sum = sum(canal_att')';


%% ajout d'un bruit blanc à ce signal.
% il faut calculer un bruit blan que l'on va ajouter au signal
% il sera de densité spectrale bilatérale N_0 /2

% bruit blanc AWGN... il existe la fonction
% awgn(signal_a_ajouter,SNR_en_db)
canal_final = canal_sum + () * randn(size(canal_sum));
