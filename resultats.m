%% resultats : On affiche tous les resultats
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% on affiche les parametres de calculs
disp('Parametres de simulation :');
disp(' ');

disp('Parametres generaux');
disp(['Nombre de cannaux : ',num2str(n)]);
disp(['Nombre de bits    : ',num2str(m)]);
disp(['Debit binaire     : ',num2str(R)]);
disp(' ');

%% parametre de l'emmetteur
disp('Parametres emmetteur');
disp(['Facteur alpha     : ',num2str(alpha)]);
disp(['Longueur filtre   : ',num2str(L)]);
disp(['Impedence calbe   : ',num2str(Z_c)]);
disp(['Puissance cable   : ',num2str(P_t)]);
disp(['Surechantillonnage: ',num2str(gamma)]);
disp(' ');

%% parametre du cannal
disp('Parametres cannal');
disp(['Attenuation       : ',num2str(alpha_n)]);
disp(['facteur delay     : ',num2str(tau_n)]);
disp(['SNR (dB)          : ',num2str(snr)]);
disp(' ');

%% parametres du recepteur
disp('Parametres recepteur');
disp(['Type de filtre    : ',type_filtre]);
disp(['Facteur ripple    : ',num2str(recepteur_ripple)]);
disp(['Resolution ADC    : ',num2str(resolution_adc)]);
disp(['Seuil décision h. : ',num2str(recepteur_decision_high)]);
disp(['Seuil décision b. : ',num2str(recepteur_decision_low)]);
disp(' ');



disp(' ');

%% on affiche les erreurs
disp('Resultats de la simulations : ');
disp(['Nombre de bits transmis : ', num2str(nb_bits_transmis)])
disp(['Nombre erreur par canal : ', num2str(transmission_error_by_canal)]);
disp(['Nombre erreur totales   : ', num2str(transmission_errors_total)]);
disp(['Taux d erreur binaire   : ', num2str(transmission_errors_total*100/nb_bits_transmis),' %'])

%% on laisse un espace pour l'affichage
disp(' ');

%% on affiche les nom
disp('Par Nicolas Segui et Pierre Paques ');
disp('2012-2013');