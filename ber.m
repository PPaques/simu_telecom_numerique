%% Bonus : BER
% Script de simulation d'une chaine complete de telecommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Bonus 2 : Le taux d'erreur binaire
% taux erreur binaire pour un canal BBGA et filtre adapte :
%
%    0.5*erfc(sqrt((Eb/N0)));
% 
% A faire : 
%   - Calculer le taux d'erreur obtenu a la sortie pour des valeurs faible
%     du rapport N
%   - Ajuster les parametres de la simulation pour se trouver dans les 
%     conditions d'un canal BBGA. Comparer a la courbe theorique. 
%     Expliquer comment vous avez ajuste la variance des  echantillons 
%     de bruit pour obtenir Eb souhaite.
%  
%   ---> considerer l'option de le faire dans un autre fichier sinon ce
%   sera trop long 
%

%% nettoyage
clear all;
close all;

%% initialisation de notre systeme de transmission
params;      % chargement des parametres

%% on surcharge le nombre de bits a transmettre et le nombre de cannaux
n=3;    % nombre de cannaux
N=n;
m = 50; % nombre de messages
type = 'compslete'; % complete
nombre_calc_by_point = 100;
calc_params; % calcul des variables dependant des parametres de simulations


%% Vecteur contenant les Eb/No a tester
Eb_under_n0_vector = [1 2 3 4 5 6 7 8 9 10];
snr_vector = 10*log10(Eb_under_n0_vector);

%% On initialise la variable de resultas
resultats_ber_butter = zeros(nombre_calc_by_point,N);
resultats_ber_chebby = zeros(nombre_calc_by_point,N);

compteur=1;
total_simulation_to_do = length(Eb_under_n0_vector)*nombre_calc_by_point;

% On passe par tous les SNR possibles
for eb = 1:length(Eb_under_n0_vector)
    % on doit surcharger la valeur du SNR. 
    % Attention elle est en  DB
    snr=snr_vector(eb);
    
    disp(['SNR :',num2str(snr)])
    
    for q = 1:nombre_calc_by_point
        % on va faire fonctionner la chaine de transmission
        emetteur; canal; 
        % enregistre pour butter
        type_filtre = 'B';
        recepteur;
        % Stockage des resultats 
        resultats_ber_butter(q,eb) = (transmission_errors_total/nb_bits_transmis);
        
        if  strcmp('complete',type) 
            %on enregistre pour Chebby
            type_filtre = 'C';
            recepteur;
            resultats_ber_chebby(q,eb) = (transmission_errors_total/nb_bits_transmis);
        end;
        
        percent_simulation = compteur*100/total_simulation_to_do;
        disp(['Progression : ',num2str(percent_simulation),' %  (',num2str(compteur),'/',num2str(total_simulation_to_do),')']);

        compteur = compteur+1;
    end
end

%% moyenne des erreurs
bit_error_rate_practical_butter = mean(resultats_ber_butter);
bit_error_rate_practical_chebby = mean(resultats_ber_chebby);

%% Courbe theorique
BER_theorique = 0.5*erfc(sqrt(10.^(Eb_under_n0_vector/10)));

   
%% on affiche le BER
figure(99);
% diag semilog ac BER theo et pratique
if strcmp('complete',type) 
    semilogy(Eb_under_n0_vector,BER_theorique,Eb_under_n0_vector, bit_error_rate_practical_butter, 'mo', Eb_under_n0_vector,bit_error_rate_practical_chebby ,'r*');
else
    semilogy(Eb_under_n0_vector,BER_theorique,Eb_under_n0_vector, bit_error_rate_practical_butter, 'mo');  
end
grid; ylabel('BER');
xlabel('E_b/N_0 [dB]');
title('Rapport entre BER et E_b/N_0');
legend('courbe theorique','Butterworth','Chebby');