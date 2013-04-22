%% Récepteur : simulation du récepteur d'un chaine de telecomunication
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Filtres analogique
% Ce sont des filtres qui vont permettre de séparer les porteuse dans les
% différentes fréquences.
% Filtres : 
%    * 1e       => passe bas
%    * suivants => passe bande

% initialisation de la matrice de filtre (performance issue)
recepteur_filtre_anal = zeros( (m+2*l)*beta*gamma, N);

% calcul des réponses impulsionnelles des N filtres analogiques
for i= 1:N
    if (i==1)
        % coefficients filtre passe bas
        %   * N = ordre du filtre
        %   * Wp = frequence à la quelle elle est appliqué
        %   * low pour filtre passe bas
        %   * s pour dire qu'on peut dépasser
        [b,a] = butter( recepteur_filter_order, ,'low');
    elseif (m>1)
        % calcul filtre passe bande 
    end
    recepteur_filtre_anal(:,m) = freqs(b,a,jesaispas); %ici mettre la fonction freqs avec nos coefficiants calculés ci dessus     
end

% filtrage du signal recu par la convolution avec le filtre
recepteur_signal_anal_conv = canal_final * recepteur_filtre_anal;


%% Récepteur idéal
% Il est constitué de : 
%    * Filtre adapté à alpha_n * p_n (t-tau_n)
%    * échantilloneur estimateur des symboles
% Il peut etre réalisé de cette manière :
%    * échantillonnage du signal sur n_b à cadence 1/t_n
%    * effectue un filtrage numérique avec un FIR adapté au FIR de l'emetteur 




%% Synchronisation
% on va utiliser la séquence pilote pour permettre d'échantillonner aux
% bons endroits
%   * Le récepteur doit générer la séquence pilote
%   * Ensuite il fait un corrélation entre la séquence pilote et le signal.
%   * le temps de synchronisation est pris là ou le résultat de la
%   corrélation est maximal
%   * Les signaux suivant sont localisé par comtage (k_0 + k * beta)



%% Récepteur simplifié
% la réalisation d'un filtre idéal est très couteux en ressources; Dans les
% récepteurs qui sont limités en ressources, on va se limiter à faire cette
% procédure
%   * filtre adapté abandonné. On estime le symbole en choissisant un
%         échantillon bien placé. On place donc un filtre de niquist complet
%         dans l'emetteur => moins bonne résistance au bruit/
%   * ADC supprimé. => remplacé par un comparateur a deux seuils symétriques. 
%         Choix des seuils doit etre important pr correspondre à la dynamique.
%   * Synchronisation sans corrélation
%         -> etude préalable de l'effet de la sequence pilote sur le
%         comparateur ET comparaison position des  déclenchements positifs et ńegatifs
%          aux instants d’ ́echantillonnage id ́eaux.



%% prise de décision
% prise de décisions selon la formule :
%   * 1 si a_n(k) appartient à S+
%   * 0 si a_n(k) appartient a S- 
%   * Indéterminé dans 3e cas
%
% Sources d’erreur:
%   * bruit additif
%   * interferences entre canaux
%   * interferences entre symboles
%   * erreurs de synchronisation
