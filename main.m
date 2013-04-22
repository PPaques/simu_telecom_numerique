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

%% EMETTEUR
emetteur;

%% CANAL
canal;

%% RECEPTEUR
%recepteur;

%% RESULTATS
%generate_fig_emetteur;
generate_fig_canal;

% stat
disp('Temps nécessaires pour la simulation :')
toc

