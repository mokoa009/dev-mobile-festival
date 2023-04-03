# dev-mobile-festival

## Description

dev-mobile-festival est une application IOS fait dans le cadre de nos études permettant la gestions de festivals, avec des créneaux d'ouverture dans différentes zones et des bénévoles pour s'occuper d'activités à faire dans chaque zone.

## Fonctionnalités

Voici une liste exhaustives de toutes les fonctionnalités implémentées :

- En tant qu'utilisateur non connecté :
    - Créer un compte pour devenir bénévole
    - Se connecter avec son compte
    - Consulter les différents festivals
    - Consulter les différentes zones
    - Consulter les zones dans lequel un festival va se dérouler
    - Consulter les différentes bénévoles existants
    - Consulter le nombre total de festivals et de bénévoles enregistrés dans l'application
- En tant que bénévole connecté :
    - Consulter son profil
    - Se déconnecter
    - S'affecter soi-même à un créneau et une zone
- En tant qu'administrateur :
    - Supprimer un festival
    - Modifier un festival
    - Clôturer un festival
    - Ajouter un festival
    - Affecter une zone à un créneau
    - Affecter un jour à un festival
    - Affecter un créneau à un jour
    - Affecter un bénévole à un créneau et une zone
    - Supprimer une zone
    - Supprimer un compte bénévole

Pour se connecter en tant qu'admin , voici un profil test : 
    - Email : Admin
    - mdp : 
(Pas de mdp )
Pour se connecter en tant que simple bénévole : 
    - Email : Emma
    - mdp : Emma ou emma

## Dépendances

L'application utilise le module JWR Decode 3.0.1 pour gérer le token lors de la connexion d'un utilisateur.

## ATTENTION

L'application a été codé avec Xcode, il y a des chances que les fichiers en .xcode plantent.  
Dans ce cas là, il faudra régler la configuration de votre Xcode.
Si cela ne marche pas, téléchargez uniquement les fichiers de l'applications (les .swift) et mettez les dans un autre projet.

## Auteurs

MATHIEU Emma & AGNESE Eri
