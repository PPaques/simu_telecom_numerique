%% résultats : On affiche tous les résultats
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% on affiche les paramètres de calculs
disp('Paramètres de simulation :');
disp(' ');

disp('Paramètres généraux');
disp(['Nombre de cannaux : ',num2str(n)]);
disp(['Nombre de bits    : ',num2str(m)]);
disp(['Débit binaire     : ',num2str(R)]);
disp(' ');

%% paramètre de l'emmetteur
disp('Paramètres emmetteur');
disp(['Facteur alpha     : ',num2str(alpha)]);
disp(['Longueur filtre   : ',num2str(L)]);
disp(['Impédence calbe   : ',num2str(P_t)]);
disp(['Puissance cable   : ',num2str(Z_c)]);
disp(['Surechantillonnage: ',num2str(gamma)]);
disp(' ');

%% paramètre du cannal
disp('Paramètres cannal');
disp(['Atténuation       : ',num2str(alpha_n)]);
disp(['facteur délay     : ',num2str(tau_n)]);
disp(['SNR (dB)          : ',num2str(snr)]);
disp(' ');

%% paramètres du récepteur
disp('Paramètres récepteur');
disp(['Type de filtre    : ',type_filtre]);
disp(['Facteur ripple    : ',num2str(recepteur_ripple)]);
disp(['Résolution ADC    : ',num2str(resolution_adc)]);
disp(' ');



disp(' ');

%% on affiche les erreurs
disp('Résultats de la simulations : ');
disp(['Nombre erreur par canal : ', num2str(transmission_error_by_canal)]);
disp(['Nombre erreur totales   : ', num2str(transmission_errors_total)]);

%% on laisse un espace pour l'affichage
disp(' ');

%% on affiche les nom
disp('Par Nicolas Segui et Pierre Paques ');
disp('2012-2013');