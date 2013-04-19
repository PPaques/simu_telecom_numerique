%% generate_fig_canal : Génération des figures du canal
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

figure(10);

plot(canal_retard_zero_ech_temps, canal_final(:,1));
xlabel('Temps');ylabel('Amplitude');title('Message 1');


