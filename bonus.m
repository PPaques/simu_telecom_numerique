%% Bonus : affichage de certains graphiques
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Bonus 1 : Le diagramme de l'oeil
% Qu'est ce que c'est ? : 
%       Il permet d'evaluer qualitativement la qualite de transmission
%       numerique lordqu'il y a de l'interference entre symbole.
% C'est la syperposition de toutes les realisations possibles du signal
% reçu dans un interval bien determine autour de l'instant
% d'echantillonnage T0. (pris par l'algo de synchro)

% Ex : [T0 - t_b; T0+ t_b]
%  L'ouverture de l'oeil donne la mesure de la qualite de transmission

% A faire : 
%    - Afficher le diagramme de l'oeil a la sortie du filtre adpate pour un
%        canal parfait (pas de bruit ni decalage analogique)
%    - Etudier l'influance du facteur alpha et de la longueur 2LTb du FIR
%        analogique sans bruit.
%    - On observe ensuite l'influance bruit, du filtrage analogique, et
%        enfin de l'interference provenantdes autres canaux
% 
% % Create an eye diagram object
% eyeObj = commscope.eyediagram(...
%     'SamplingFrequency', 1/T_a, ...
%     'SamplesPerSymbol', 1000, ...
%     'OperationMode', 'Real Signal')
% 
% eyeObj.MinimumAmplitude = -5;
% eyeObj.MaximumAmplitude = 5;
% 
% % Update the eye diagram object with the transmitted signal
% eyeObj.update(0.5*signal_FA(:,2));
% 
% % Manage the figures
% managescattereyefig(hFig, eyeObj, 'right');


%% Bonus 2 : Le taux d'erreur binaire
% voir fichier ber.m

%% Bonus 3 : Les filtres analogiques
% Afficher pour les filtres suivants et pour les 3 premiers ordres : 
%       - Butterworth
%       - Chebyshev type 1
%       - Chebyshev type 2
%       - Cauer
%       - Bessel
%   -> module de la fonction de transfert
%   -> delais de groupe
%   -> reponse impulsionnelle

% etape 1 : Creer tous les filtres
% parametres : 
bonus_filtres_ordre = 1;
bonus_filtrer_bp = 0.5;
bonus_filtrer_ldac = 12;
bonus_filter_fa = 1000;
bonus_filter_f_freqs = 200;
bonus_filter_ripple = 0.5;  
bonus_filter_attenuation = 20;

% butter
for bb= 1:3
    [coebb,coeba] = butter(bb, bonus_filtrer_bp,'low', 's');
    [gd_bb(:,bb),w] = grpdelay(coebb,coeba); %delai de groupe
    bonus_filter_butter(:,bb) = freqs(coebb, coeba, bonus_filter_f_freqs)';
    %bonus_filter_butter_gd(:,bb) = grpdelay(coebb,coeba,100);
    %bonus_filter_butter_pd(:,bb) = -unwrap(angle(bonus_filter_butter(:,bb)));
end

% on affiche le butter
figure(100)
hold on;
plot(mag2db(abs(bonus_filter_butter)));
title(['Filtre de Butter']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%delai groupe du butter
figure(101)
hold on
plot(w/pi*180,gd_bb);
title(['D�lai de groupe de Butter']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%reponse impulsionnelle
ri_butter = real(ifft(bonus_filter_butter));


% Cheby1
for cc= 1:3
    [coebb,coeba] = cheby1(cc, bonus_filtrer_bp,bonus_filter_ripple, 'low', 's');
    [gd_cc(:,cc),w] = grpdelay(coebb,coeba); %delai de groupe
    bonus_filter_cheby(:,cc) = freqs(coebb, coeba, bonus_filter_f_freqs)';
    %bonus_filter_butter_gd(:,bb) = grpdelay(coebb,coeba,100);
    %bonus_filter_butter_pd(:,bb) = -unwrap(angle(bonus_filter_butter(:,bb)));
end

% on affiche le cheby1
figure(105)
hold on;
plot(mag2db(abs(bonus_filter_cheby)));
title(['Filtre de Cheby1']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%delai groupe du cheby1
figure(106)
hold on
plot(w/pi*180,gd_cc);
title(['D�lai de groupe de Cheby1']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');


% Cheby2 OK ! (les parametres a envoyer etaient differents, pas de ripple
% dans celui-ci
for ccc= 1:3
    [coebb,coeba] = cheby2(ccc, bonus_filter_attenuation, bonus_filtrer_bp, 'low', 's');
    [gd_ccc(:,ccc),w] = grpdelay(coebb,coeba); %delai de groupe
    bonus_filter_cheby_two(:,ccc) = freqs(coebb, coeba, bonus_filter_f_freqs)';
end

% on affiche le cheby2
figure(110)
hold on;
plot(mag2db(abs(bonus_filter_cheby_two)));
title(['Filtre de Cheby2']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%delai groupe du cheby2
figure(111)
hold on
plot(w/pi*180,gd_ccc);
title(['D�lai de groupe de Cheby2']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

% cauer OK (parametres changes et testes)
for ccc= 1:3
    [coebb,coeba] = ellip(ccc, bonus_filter_ripple, bonus_filter_attenuation,bonus_filter_f_freqs, 'low', 's');
    [gd_cau(:,ccc),w] = grpdelay(coebb,coeba); %d�lai de groupe
    bonus_filter_cauer(:,ccc) = freqs(coebb, coeba, bonus_filter_f_freqs)';
end

% on affiche le cauer 
figure(115)
hold on;
plot(mag2db(abs(bonus_filter_cauer)));
title(['Filtre de Cauer']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%d�lai groupe du cauer
figure(116)
hold on
plot(w/pi*180,gd_cau);
title(['D�lai de groupe de Cauer']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

% bessel
for ccc= 1:3
    [coebb,coeba] = besself(ccc, bonus_filtrer_bp);
    [gd_bes(:,ccc),w] = grpdelay(coebb,coeba); %delai de groupe
    bonus_filter_bessel(:,ccc) = freqs(coebb, coeba, bonus_filter_f_freqs)';
end

% on affiche le bessel
figure(120)
hold on;
plot(mag2db(abs(bonus_filter_bessel)));
title(['Filtre de Bessel']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');

%delai groupe du cauer
figure(121)
hold on
plot(w/pi*180,gd_bes);
title(['D�lai de groupe de Bessel']);
legend('Ordre 1', 'Ordre 2', 'Ordre 3');


%% Bonus 4 : Affichage de la synchronisation
% juste un beau graphe montrant les instants d'echantillonnage avec les
% differentes piques
