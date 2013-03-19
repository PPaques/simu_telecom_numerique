%% Main : scipt principal
% Script de simulation d'une chaine complète de télécommunications
% Par Nicolas Segui et Pierre Paques
% 2012-2013

%% Nettoyage
clear all;
close all;
% stat
tic

%% initialisation
% chargement des paramètres
params;

% calcul des variables dependant des paramètres de simulations
calc_params;

%% calcul des signaux dans l'emetteur
emetteur;

%% affichage des résultats
% peut-etre faire un fichier qui génère toutes les figures ? :)

generate_fig;

% stat
disp('Temps nécessaires pour la simulation :')
toc
