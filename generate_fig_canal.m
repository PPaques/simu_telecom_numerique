%% generate_fig_canal : Generation des figures du canal
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013
message_en_cours = 2;

%Comparaison entre le signal en sortie de l'emetteur et apres dephasage
figure(10);
plot(canal_retard_zero_ech_temps, canal_retard_zero(:,message_en_cours), 'b', 'LineWidth',2)
hold on
plot(canal_retard_zero_ech_temps, canal_time(:,message_en_cours), 'r', 'LineWidth',2)
xlabel('Temps');ylabel('Amplitude');title('Dephasage du Signal');
legend('Sortie de l''emetteur','Dephase','Location','NorthEast')
hold off ;

%comparaison du signal dephase et du signal dephase et attenue
figure(11);
plot(canal_retard_zero_ech_temps, canal_time(:,message_en_cours), 'r', 'LineWidth',2)
hold on
plot(canal_retard_zero_ech_temps, canal_att(:,message_en_cours), 'k', 'LineWidth',2)
xlabel('Temps');ylabel('Amplitude');title('Attenuation du signal');
legend('Dephase','Dephase et attenue','Location','NorthEast')
hold off;

figure(12)
plot(canal_retard_zero_ech_temps, canal_att_bruit(:,message_en_cours), 'g');
hold on
plot(canal_retard_zero_ech_temps, canal_att(:,message_en_cours), 'k', 'LineWidth',2)
xlabel('Temps');ylabel('Amplitude');title('Bruitage du signal');
legend('Bruite','Dephase et attenue','Location','NorthEast')
hold off;

% affichage sortie canal

figure(13)
plot(canal_retard_zero_ech_temps, canal_final, 'g');
hold on
plot(canal_retard_zero_ech_temps, canal_sum);
xlabel('Temps');ylabel('Amplitude');title('Signal complet a la sortie du canal');
legend('Signal complet bruite','Signal complet','Location','NorthEast')
hold off;





