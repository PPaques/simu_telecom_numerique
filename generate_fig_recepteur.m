%% generate_fig_emetteur : génère toutes les figures du récepteur 
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% filtrage 
% Affichage de la réponse en fréquence des filtres %%OK!!
figure(30)
plot(f_freqs,(abs(filtres_coeff)));
title(['Réponse en fréquence des filtres générés']);
axis([0 (2*N/T_b) 0 1]); grid;
xlabel('Fréquence (Hz)');
ylabel('Amplitude du spectre') ;     

% affichage des filtres en temporel : normal et tronqué
for i = 1 : N
    figure(30+i)
    plot(filtres_a_temporel(:,i))
    title(['Réponse impulsionnelle du canal ',int2str(i)])
    grid;
    xlabel('Nombre d''échantillons');
    ylabel('Amplitude');
% 
%         figure
%         plot(h_t_tronc(:,i))
%         title(['Réponse impulsionnelle du canal ',int2str(i),' tronquée'])
%         grid
%         xlabel('Nombre d''échantillons')
%         ylabel('Amplitude')
end

%     % affichage de l'influence de la troncature
% 	figure(36)
%     amp = max(abs(H(:,1)));
%     plot(fi,abs(H(:,:)),fi,abs(H_tronc(:,:)))
%     title(['Influence de la troncature'])
%     axis([0 (2*N/Tb) 0 amp])
%     xlabel('Fréquence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid
%     
%     % affichage du filtrage du signal
% 	figure
%     amp = max(abs(fft(R_tot)));
%     plot(fi,2*amp*abs(H_tronc(:,:)),fi*2,abs(fft(R_tot)))
%     title(['Filtrage aux différentes porteuses'])
%     axis([0 (2*N/Tb) 0 amp*1.5])
%     xlabel('Fréquence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid
%     
%     % signal filtré aux différentes porteuses
%     figure
%     plot(frn,abs(fft(rn_an)))
%     title(['Signal filtré aux différentes porteuses'])
%     axis([0 (2*(N-1)/Tb+Bp/(2*pi)) 0 amp/2]) 
%     xlabel('Fréquence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid


%% synchronisation
% Filtre de la séquence pilote généré dans la synchro
figure(40)
plot(recepteur_sync_filtre_n);
xlabel('Echantillons');
title('Filtres généré pour la séquence pilote (Temporel)');
legend('canal 1','canal 2', 'canal 3');

% filtre pilote en fréquentiel
figure(31);
plot(fftshift(abs(fft(recepteur_sync_filtre_n))));
xlabel('Echantillons');
title('Filtres généré pour la séquence pilote (fréquentiel)');
legend('canal 3','canal 2', 'canal 1');


% affichage de la corrélation entre le signal et la séquence pilote et
% prise du poinr maximal
for i = 1:N
    amp = max(recepteur_xcorr_x(:,i))*1.2;
    figure(41+i)
    plot(recepteur_xcorr_y(:,i)*T_n,recepteur_xcorr_x(:,i),'',recepteur_xcorr_y(recepteur_xcorr_max(1,i),n)*T_n,recepteur_xcorr_x(recepteur_xcorr_max(1,i),i),'c*',recepteur_xcorr_y(recepteur_xcorr_max(1,i),i),recepteur_xcorr_x(recepteur_xcorr_max(1,i),i),'co')
    title(['Corrélation du signal ',int2str(i),' avec la séquence pilote avec un Délai de ',num2str(recepteur_retards(1,i)*1000*T_n),'ms'])
    axis([recepteur_xcorr_y(1,i)*T_n recepteur_xcorr_y(end,i)*T_n -amp amp])
    xlabel('Temps (s)');
    ylabel('Amplitude du signal');
    grid
end


% affichage de la synchronisation de la séquence pilote sur le signal
amp = max(abs(signal_FA(:,1)))*1.2;
amp2 = max(abs(recepteur_sync_seq_pilote(:,1)));
figure(50)
plot(T_n_FA,signal_FA(:,1),'',recepteur_sync_filtre_n_t+recepteur_retards(1,1)*T_n,amp*recepteur_sync_seq_pilote(:,1)/amp2,'');
axis([recepteur_retards(1,1)*T_n (length(recepteur_sync_seq_pilote)+recepteur_retards(1,1))*T_n -amp amp]);
title(['Synchronisation de la séquence pilote sur le signal R tot 0(t) filtré']);
xlabel('Temps (s)');
ylabel('Amplitude du signal') ;
legend('Signal reçu','Séquence pilote');
grid

% affichage des instants d'échantillonnage
for i = 1:N
    amp = max(abs(signal_FA(:,i)))*1.20;
    figure (50+i)
    plot(T_n_FA,signal_FA(:,i),'',T_n_FA(k(:,i)),signal_FA(k(:,i),n),'*');
    title(['Estimation des symboles sur le signal R tot ',int2str(i),'(t)']);
    xlabel('Temps (s)'); ylabel('Amplitude du signal') ;
    legend('Signal reçu','Symboles estimés');
    grid
end
