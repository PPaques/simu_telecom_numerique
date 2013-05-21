%% Recepteur : simulation du recepteur d'un chaine de telecomunication
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Filtres analogique
% Ce sont des filtres qui vont permettre de separer les porteuse dans les
% differentes frequences.
% Filtres : 
%    * 1e       => passe bas
%    * suivants => passe bande

% initialisation de la matrice de filtre (performance issue)

f_freqs = Fa/2*(0:1:(l_dac-1))/(l_dac);
recepteur_filtre_analog = zeros(l_dac, N);

% Filtre pour le canal 1
% Chebyshev
if type_filtre == 'C'
    [b,a] = cheby1(recepteur_ordre, recepteur_ripple, b_pass,'low','s');
end
% Butterworth
if type_filtre == 'B'
    [b,a] = butter(recepteur_ordre, b_pass,'low','s');
end
% On construit le spectre frequenciel au depart des coefficients trouves
filtres_coeff(:, 1) = freqs(b, a, f_freqs)';

% Filtre pour les canaux 2..N
for i = 1:N-1
    % Chebyshev
    if type_filtre == 'C'
        [b,a] = cheby1(recepteur_ordre, recepteur_ripple, [W_n(i)/(2*pi)-b_pass W_n(i)/(2*pi)+b_pass], 'bandpass', 's');
    end
    % Butterworth
    if type_filtre == 'B'
        [b,a] = butter(recepteur_ordre, [W_n(i)/(2*pi)-b_pass W_n(i)/(2*pi)+b_pass], 'bandpass', 's');
    end
    % On construit le spectre frequenciel au depart des coefficients trouves
    filtres_coeff (:,1+i) = freqs(b, a, f_freqs)';
end

% Symetrie des filtres pour ajouter les frequences miroires
filtres_a = zeros(2*l_dac,N);
%filtres_a = zeros(l_dac,N);
filtres_a(1:l_dac,:) = filtres_coeff;
filtres_a(2*l_dac:-1:l_dac+1,:) = conj(filtres_coeff);

% Calcul de la reponse impulsionnelle des filtres
filtres_a_temporel = real(ifft(filtres_a));
filtres_a_temporel = fliplr(filtres_a_temporel')';




% filtrage du signal recu par la convolution avec le filtre 
recepteur_signal_anal_conv = zeros(length(conv(canal_final,filtres_a_temporel(:,1))),N);
for i=1:N
    conv_temp = conv(canal_final,filtres_a_temporel(:,i));
    recepteur_signal_anal_conv(:,i) = conv_temp(:,1);
end


%% Mise a l'echelle (auto-gain)
% chaque canal subit une att�nuation differente en plus de l'apmplifaction pour l'amener a la puissance voulue
% le gain a appliquer est donc calcule pour chaque canal pour la plus haute crete soit a 1
ech_max = zeros(1,N);
signal_mit_echelle = zeros(length(recepteur_signal_anal_conv),N);
    
for i = 1:N 
    ech_max(1,i)= max(abs(recepteur_signal_anal_conv(:,i)));
    signal_mit_echelle(:,i) = recepteur_signal_anal_conv(:,i) ./ ech_max(:,i);
end;
%plot(signal_mis_echelle)

%% Recepteur ideal
% Il est constitue de : 
%    * Filtre adapte a alpha_n * p_n (t-tau_n)
%    * echantilloneur estimateur des symboles
% Il peut etre realise de cette maniere :
%    * echantillonnage du signal sur n_b a cadence 1/t_n
%    * effectue un filtrage numerique avec un FIR adapte au FIR de l'emetteur 

% Echantillonage (downsample pour passer analo au numerique)
recepteur_echantillon = downsample(signal_mit_echelle,gamma);% sousechantillonnage
T_n_recep = (0:1:(length(recepteur_signal_anal_conv)-1)/gamma)*T_n; % base de temps recepteur


% Quantification 
codebook = -1:(2/2^resolution_adc):1;
partition = (-1+(1/2^resolution_adc)):(2/2^resolution_adc):(1-(1/2^resolution_adc));

signal_quantif = zeros(length(recepteur_echantillon),N); %prealocation memoire
for i = 1:N
    [index, signal_quantif(:,i)] = quantiz(recepteur_echantillon(:,i),partition,codebook);
end
%plot(T_n_recep,signal_quantif);

%convolution filtre numerique
signal_FA = zeros(length(conv(signal_quantif(:,1),p_n(:,1))),N); %Signal apres passage dans le Filtre Adapte
T_n_FA = 0:T_n:(length(conv(signal_quantif(:,1),p_n(:,1)))-1)*T_n; %base de temps apres filtre adapte, a voir si on garde
for i = 1:N        
    signal_FA(:,i)=conv(signal_quantif(:,i),p_n(:,i));
end;

%plot(T_n_FA,signal_FA)


%% Synchronisation
% on va utiliser la sequence pilote pour permettre d'echantillonner aux
% bons endroits
%   * Le recepteur doit generer la sequence pilote
%   * Ensuite il fait un correlation entre la sequence pilote et le signal.
%   * le temps de synchronisation est pris la ou le resultat de la
%   correlation est maximal
%   * Les signaux suivant sont localise par comtage (k_0 + k * beta)

% generation de la sequence pilote 
% on effectue la pam sur la sequence pilote
recepteur_sequence_pilote_pam = (sequence_pilote.*2)-1;

% maintenant on doit surechantillonner du facteur beta
recepteur_sequence_pilote_pam_surech = upsample(recepteur_sequence_pilote_pam,beta) *ones(1,N); %n_can (modif nico)

% on ne peut pas recuperer le filtre de l'emetteur car il est en racine de
% nyquist. Or nous avons vu que le systeme passe dans deux filtres en
% racine de nyquist. On doit donc passer la sequence pilote dans un filtre
% de nyquist.
recepteur_sync_filtre_ni = rcosfir(alpha,L,beta,T_b)';
recepteur_sync_filtre_n = [recepteur_sync_filtre_ni (recepteur_sync_filtre_ni*ones(1,n-1)).*cos(t*W_n)];

recepteur_sync_filtre_n_t = 0:T_n:(length(conv(recepteur_sequence_pilote_pam_surech(:,1), recepteur_sync_filtre_n(:,1)))-1)*T_n;

% initialisation de la sequence pilote
recepteur_sync_seq_pilote = zeros(length(conv(recepteur_sequence_pilote_pam_surech(:,1), recepteur_sync_filtre_n(:,1))),N);

for i=1:N
    recepteur_sync_seq_pilote(:,i) = conv(recepteur_sequence_pilote_pam_surech(:,i), recepteur_sync_filtre_n(:,i));
end

% on a maintenant une sequence pilote qui est generee a� l'identique que
% dans l'emetteur (recepteur_sync_seq_pilote)

% il faut convoluer la sequence pilote et le signal.
% initialisation des variables (performance issue)
recepteur_long_correlation = (length(recepteur_sync_seq_pilote)+beta*1.5)*2-1; % A trouver 
recepteur_xcorr_x   = zeros(recepteur_long_correlation,N); %valeur de la correlation
recepteur_xcorr_y   = zeros(recepteur_long_correlation,N); %valeur du decalage entre le signal et la sequence pilote
recepteur_xcorr_max_indice = zeros(1,N);
recepteur_retards   = zeros(1,N);


% On recupere une liste des instants ou la correlation est maximale

for i=1:N
    % on effectue la correlation
    [recepteur_xcorr_x(:,i) recepteur_xcorr_y(:,i)] = xcorr(signal_FA(1:length(recepteur_sync_seq_pilote)+beta*1.5,i), recepteur_sync_seq_pilote(:,i)); 
    % on trouve les maximum de correlation 
    recepteur_xcorr_max_indice(1,i) = find(recepteur_xcorr_x(:,i) == max(recepteur_xcorr_x(:,i) )); %trouve l'indice de la valeur Maximale
    % on trouve les delais entre correlation
    recepteur_retards(1,i) = recepteur_xcorr_y(recepteur_xcorr_max_indice(1,i),i);   
end

%stem(recepteur_retards) %affichage des retards
%t_i = (randi(10,1,1)-5)/100;+floor(t_i*L*beta) invertitude sur l'instant
%de synchro


an_k = zeros(m,N); %matrice des symboles
k = zeros(m,N); %autre matrice des symboles
k0 = zeros(1,N); %matrice des d�calages
for i = 1:N
    k0(:,i) = recepteur_retards(1,i)+L*beta; %L*beta = un echantantillon dans la base temps du filtre + retard. Si pas de retard, on prend la valeur en L*beta
    k(:,i) = ((k0(:,i)+1):beta:(k0(:,i)+m*beta));
    an_k(:,i) = signal_FA(k(:,i),i);
end

%% prise de decision
% prise de decisions selon la formule :
%   * 1 si a_n(k) appartient a S+
%   * 0 si a_n(k) appartient a S- 
%   * Indetermine dans 3e cas
%
% Sources d'erreur:
%   * bruit additif
%   * interferences entre canaux
%   * interferences entre symboles
%   * erreurs de synchronisation

% a ete simplifie par manque de temps 

r = an_k;
r(r>recepteur_decision_high) = 1;
r(r<recepteur_decision_low) = 0;

%% calcul du nombre d'erreur
%xor(message,r)
transmission_error_by_canal = sum(xor(message,r));
transmission_errors_total = sum(sum(xor(message,r))');

%compte l   

%% Recepteur simplifie
% la realisation d'un filtre ideal est tres couteux en ressources; Dans les
% recepteurs qui sont limites en ressources, on va se limiter a faire cette
% procedure
%   * filtre adapte abandonne. On estime le symbole en choissisant un
%         echantillon bien place. On place donc un filtre de niquist complet
%         dans l'emetteur => moins bonne resistance au bruit/
%   * ADC supprime. => remplace par un comparateur a deux seuils symetriques. 
%         Choix des seuils doit etre important pr correspondre a la dynamique.
%   * Synchronisation sans correlation
%         -> etude prealable de l'effet de la sequence pilote sur le
%         comparateur ET comparaison position des  declenchements positifs et negatifs
%          aux instants d' echantillonnage id eaux.

% Non realise dans le cadre de ce rapport
