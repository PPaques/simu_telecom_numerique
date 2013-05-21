%% generate_fig_emetteur : genere toutes les figures de l'emetteur
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013


%% Emmetteur

% signal de depart
figure(1);

subplot(231)
stem(message_ech_temps,message(:,1),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 1');

subplot(232)
stem(message_pam_ech_temps,message_pam(:,1),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 1 : PAM');

subplot(233)
stem(message_surech_pam_ech_temps,message_surech_pam(:,1),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 1 : sur-echantillonne');

subplot(234)
stem(message_ech_temps,message(:,2),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 2');

subplot(235)
stem(message_pam_ech_temps,message_pam(:,2),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 2 : PAM');

subplot(236)
stem(message_surech_pam_ech_temps,message_surech_pam(:,2),'*');
xlabel('Temps');ylabel('Amplitude');title('Message 2 : sur-echantillonne');

% comparaison des longueurs filtres FIR
figure(2);

subplot(141)
plot(rcosfir(alpha,2,beta,T_b,'sqrt')')
xlabel('Echantillons');title('Filtre FIR Longueur 2'); grid on;

subplot(142)
plot(rcosfir(alpha,4,beta,T_b,'sqrt')')
xlabel('Echantillons');title('Filtre FIR Longueur 4');grid on;

subplot(143)
plot(rcosfir(alpha,20,beta,T_b,'sqrt')')
xlabel('Echantillons');title('filtre FIR Longueur 100');grid on;

subplot(144)
plot(rcosfir(alpha,100,beta,T_b,'sqrt')')
xlabel('Echantillons');title('filtre FIR Longueur 100');grid on;

% comparaison pour differents facteurs de rolof
figure(3);
subplot(231)
plot(rcosfir(0,L,beta,T_b,'sqrt')')
xlabel('Echantillons');title('Facteur Rolloff 0'); grid on;

subplot(232)
plot(rcosfir(0.5,L,beta,T_b,'sqrt')')
xlabel('Echantillons');title('Facteur Rolloff 0.5');grid on;

subplot(233)
plot(rcosfir(1,L,beta,T_b,'sqrt')')
xlabel('Echantillons');title('Facteur Rolloff 1');grid on;

subplot(234)
plot(fftshift(abs(fft(rcosfir(0,L,beta,T_b,'sqrt')'))))
xlabel('Echantillons');title('Facteur Rolloff 0');grid on;

subplot(235)
plot(fftshift(abs(fft(rcosfir(0.5,L,beta,T_b,'sqrt')'))))
xlabel('Echantillons');title('Facteur Rolloff 0.5');grid on;

subplot(236)
plot(fftshift(abs(fft(rcosfir(1,L,beta,T_b,'sqrt')'))))
xlabel('Echantillons');title('Facteur Rolloff 1');grid on;

% affichage de notre filtre reparti sur plusieurs frequences
figure(4);
subplot(211)
plot(p_n)
title('Filtres en temporel');grid on;

subplot(212)
plot(p_n_ech_freq, fftshift(abs(fft(p_n))));  % on utilise fft shift pour que l'affichage en frequence soit beau
xlabel('Frequence');title('Filtre en frequentiel');grid on;

% Message convolue et interpole
figure(5);

subplot(211)
plot(x, message_conv(:,1), 'o',xi,message_interpol(:,1))
title('Message devant etre envoye sur le canal 1'); grid on;
subplot(212)
plot(xi, emetteur_final(:,1))
title('message final sur le canal 1 (bonne puissance)'); grid on;
