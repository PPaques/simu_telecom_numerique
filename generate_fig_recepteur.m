%% generate_fig_emetteur : genere toutes les figures du recepteur 
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% filtrage 
% Affichage de la reponse en frequence des filtres %%OK!!
figure(30)
plot(f_freqs,(abs(filtres_coeff)));
title(['Reponse en frequence des filtres generes']);
axis([0 (2*N/T_b) 0 1]); grid;
xlabel('Frequence (Hz)');
ylabel('Amplitude du spectre') ;     

% affichage des filtres en temporel : normal et tronque
for i = 1 : N
    figure(30+i)
    plot(filtres_a_temporel(:,i))
    title(['Reponse impulsionnelle du canal ',int2str(i)])
    grid;
    xlabel('Nombre d''echantillons');
    ylabel('Amplitude');
% 
%         figure
%         plot(h_t_tronc(:,i))
%         title(['Reponse impulsionnelle du canal ',int2str(i),' tronquee'])
%         grid
%         xlabel('Nombre d''echantillons')
%         ylabel('Amplitude')
end

%     % affichage de l'influence de la troncature
% 	figure(36)
%     amp = max(abs(H(:,1)));
%     plot(fi,abs(H(:,:)),fi,abs(H_tronc(:,:)))
%     title(['Influence de la troncature'])
%     axis([0 (2*N/Tb) 0 amp])
%     xlabel('Frequence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid
%     
%     % affichage du filtrage du signal
% 	figure
%     amp = max(abs(fft(R_tot)));
%     plot(fi,2*amp*abs(H_tronc(:,:)),fi*2,abs(fft(R_tot)))
%     title(['Filtrage aux differentes porteuses'])
%     axis([0 (2*N/Tb) 0 amp*1.5])
%     xlabel('Frequence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid
%     
%     % signal filtre aux differentes porteuses
%     figure
%     plot(frn,abs(fft(rn_an)))
%     title(['Signal filtre aux differentes porteuses'])
%     axis([0 (2*(N-1)/Tb+Bp/(2*pi)) 0 amp/2]) 
%     xlabel('Frequence (Hz)')
%     ylabel('Amplitude du spectre')    
%     grid


%% synchronisation
% Filtre de la sequence pilote genere dans la synchro
figure(40)
plot(recepteur_sync_filtre_n);
xlabel('Echantillons');
title('Filtres genere pour la sequence pilote (Temporel)');
legend('canal 1','canal 2', 'canal 3');

% filtre pilote en frequentiel
figure(31);
plot(fftshift(abs(fft(recepteur_sync_filtre_n))));
xlabel('Echantillons');
title('Filtres genere pour la sequence pilote (frequentiel)');
legend('canal 3','canal 2', 'canal 1');


% affichage de la correlation entre le signal et la sequence pilote et
% prise du poinr maximal
for i = 1:N
    amp = max(recepteur_xcorr_x(:,i))*1.20;
    figure(41+i)
    plot(recepteur_xcorr_y(:,i)*T_n,recepteur_xcorr_x(:,i),'',recepteur_xcorr_y(recepteur_xcorr_max_indice(1,i),i)*T_n,recepteur_xcorr_x(recepteur_xcorr_max_indice(1,i),i),'c*',recepteur_xcorr_y(recepteur_xcorr_max_indice(1,i),i),recepteur_xcorr_x(recepteur_xcorr_max_indice(1,i),i),'co')
    title(['Correlation du signal ',int2str(i),' avec la sequence pilote avec un Delai de ',num2str(recepteur_retards(1,i)*1000*T_n),'ms'])
    axis([recepteur_xcorr_y(1,i)*T_n recepteur_xcorr_y(end,i)*T_n -amp amp])
    xlabel('Temps (s)');
    ylabel('Amplitude du signal');
    grid
end


% affichage de la synchronisation de la sequence pilote sur le signal
amp = max(abs(signal_FA(:,1)))*1.2;
amp2 = max(abs(recepteur_sync_seq_pilote(:,1)));
figure(50)
plot(T_n_FA,signal_FA(:,1),'',recepteur_sync_filtre_n_t+recepteur_retards(1,1)*T_n,amp*recepteur_sync_seq_pilote(:,1)/amp2,'');
axis([recepteur_retards(1,1)*T_n (length(recepteur_sync_seq_pilote)+recepteur_retards(1,1))*T_n -amp amp]);
title(['Synchronisation de la sequence pilote sur le signal R tot 0(t) filtre']);
xlabel('Temps (s)');
ylabel('Amplitude du signal') ;
legend('Signal reçu','Sequence pilote');
grid

% affichage des instants d'echantillonnage
for i = 1:N
    amp = max(abs(signal_FA(:,i)))*1.20;
    figure (50+i)
    plot(T_n_FA,signal_FA(:,i),'',T_n_FA(k(:,i)),signal_FA(k(:,i),i),'*');
    title(['Estimation des symboles sur le signal R tot ',int2str(i),'(t)']);
    xlabel('Temps (s)'); ylabel('Amplitude du signal') ;
    legend('Signal reçu','Symboles estimes');
    grid
end
