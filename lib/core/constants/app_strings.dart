abstract class AppStrings {
  static String _languageCode = 'fr';

  static String get languageCode => _languageCode;

  static void setLanguage(String code) {
    _languageCode = code;
  }

  static String _t(String key) {
    return _values[_languageCode]?[key] ?? _values['fr']![key] ?? key;
  }

  static const Map<String, Map<String, String>> _values = {
    'fr': {
      'adresse': 'Adresse',
      'adresseDuParking': 'Adresse du parking',
      'aiSummary': 'AI Summary',
      'ajouter': 'Ajouter',
      'ajouterUnVehicule': 'Ajouter un véhicule',
      'ajouterUneCarteBancaire': 'Ajouter une carte bancaire',
      'ajouterUnePlaqueDimmatriculation':
          "Ajouter une plaque d'immatriculation",
      'ajoutezAuMoins3PhotosPour':
          'Ajoutez au moins 3 photos pour mettre en\nvaleur votre emplacement',
      'ajoutezDesPhotos': 'Ajoutez des photos',
      'annoncePubliee': 'Annonce publiée !',
      'annuler': 'Annuler',
      'appareilsDeconnectesAvecSucces': 'Appareils déconnectés avec succès',
      'archiver': 'Archiver',
      'archiverCeParking': 'Archiver ce parking ?',
      'areYouSureYouWantTo':
          'Are you sure you want to cancel this reservation?',
      'aucunHistoriqueDisponible': 'Aucun historique disponible.',
      'aucunLieuTrouve': 'Aucun lieu trouvé',
      'aucunPaiementEffectuePourLeMoment':
          'Aucun paiement effectué pour le moment',
      'aucunResultatTrouve': 'Aucun résultat trouvé',
      'aucuneNotification': 'Aucune notification',
      'autorisationDeLaMunicipalite':
          '• Autorisation de la municipalité\n'
          '• Titre de propriété ou bail\n'
          '• Attestation d’assurance\n'
          '• Certificat de conformité (si terrain)',
      'bestMatch': '⭐ Best Match',
      'bonjour': 'Bonjour 👋',
      'cancelReservation': 'Cancel reservation?',
      'capaciteHoraires': 'Capacité & horaires',
      'caracteristiques': 'Caractéristiques',
      'cetteActionEstIrreversibleVoulezVous':
          'Cette action est irréversible. Voulez-vous vraiment supprimer votre compte ?',
      'chezTuniparkLaProtectionDeVos':
          'Chez Tunipark, la protection de vos données personnelles est une priorité.',
      'commencezASaisirUneAdresse': 'Commencez à saisir une adresse',
      'compatibleAvec': 'Compatible avec',
      'conditionsDUtilisation': "Conditions d'utilisation",
      'confirmer': 'Confirmer',
      'connectezVousPourAccederAVotre':
          'Connectez-vous pour accéder à votre compte.',
      'creerUnCompte': 'Créer un compte',
      'decrivezVotreEmplacement': 'Décrivez votre emplacement',
      'definissezVosPrixVousPourrezLes':
          'Définissez vos prix. Vous pourrez les modifier à tout moment.',
      'derniereMiseAJour1erJanvier': 'Dernière mise à jour : 1er janvier 2025',
      'description': 'Description',
      'devenezPartenaireTuniparkEtCommencezA':
          'Devenez partenaire TuniPark et commencez à\nrentabiliser votre garage, sous-sol ou espace privé.',
      'dimensionsDeLaPlace': 'Dimensions de la place',
      'documentsLegaux': 'Documents légaux',
      'dt': 'DT',
      'echecDeLaPublication': 'Échec de la publication',
      'editerLeProfil': 'Editer le profil',
      'enAttenteDeConfirmationDuPaiement':
          'En attente de confirmation du paiement…',
      'enUtilisantTuniparkVousConfirmezAvoir':
          'En utilisant Tunipark, vous confirmez avoir lu et accepté ces conditions dans leur intégralité.',
      'entrezEtSortezDeVotreParking':
          "Entrez et sortez de votre parking sans devoir utiliser l'application Tunipark",
      'fixerVosTarifs': 'Fixer vos tarifs',
      'francais': 'Français',
      'gpsIsDisabledPleaseEnableLocation':
          'GPS is disabled. Please enable location.',
      'historique': 'Historique',
      'horairesD': "Horaires d'",
      'indiquezCombienDePlacesVousProposez':
          'Indiquez combien de places vous proposez, vos horaires et les véhicules acceptés.',
      'informationsDeL': "Informations de l'",
      'informationsMisesAJour': 'Informations mises à jour',
      'inscriptionReussie': 'Inscription réussie !',
      'inscrivezVousPourAccederAVotre':
          'Inscrivez-vous pour accéder à votre compte.',
      'itineraire': 'Itinéraire',
      'laDateSelectionneeDoitEtrePosterieure':
          'La date sélectionnée doit être postérieure à la date minimale.',
      'langue': 'Langue',
      'locationPermissionDenied': 'Location permission denied.',
      'locationPermissionPermanentlyDeniedOpenApp':
          'Location permission permanently denied. Open app settings.',
      'mesAnnonces': 'Mes annonces',
      'mesPaiements': 'Mes paiements',
      'mesReservations': 'Mes réservations',
      'mesVehicules': 'Mes véhicules',
      'mettezAJourL': "Mettez à jour l'",
      'mode': 'Mode',
      'modifier': 'Modifier',
      'motDePasseModifieAvecSucces': 'Mot de passe modifié avec succès',
      'motDePasseOublie': 'Mot de passe oublié ?',
      'motDePasseReinitialise': 'Mot de passe réinitialisé !',
      'no': 'Non',
      'noReservationsFound': 'Aucune réservation trouvée',
      'notifications': 'Notifications',
      'nousContacterPourVosDroits': 'Nous contacter pour vos droits',
      'optionCarteDAcces': "Option carte d'accès",
      'ou': 'Ou',
      'ouSeSitueVotreEmplacement': 'Où se situe votre emplacement ?',
      'paiement100Securise': 'Paiement 100% sécurisé',
      'paiementReussi': 'Paiement réussi !',
      'paiementSecuriseViaLApplication': "Paiement sécurisé via l'application",
      'parkingArchiveAvecSucces': 'Parking archivé avec succès',
      'parkingMisAJourAvecSucces': 'Parking mis à jour avec succès',
      'partager': 'Partager',
      'placeVoiture': 'Place voiture',
      'placesDisponibles': 'Places disponibles',
      'politiqueDeConfidentialite': 'Politique de confidentialité',
      'pourModifierLaPositionGpsUtilisez':
          "Pour modifier la position GPS, utilisez la carte dans l'",
      'pourToutVehicule': 'Pour tout véhicule',
      'prenezDesPhotosClairesMontrantLemplacement':
          "Prenez des photos claires montrant l'emplacement, l'accès et les environs.",
      'publicationEnCours': 'Publication en cours…',
      'publierMonPremierParking': 'Publier mon premier parking',
      'publiezSurTuniparkCestFacile': "Publiez sur TuniPark ,\nc'est facile",
      'quelTypeD': "Quel type d'",
      'rechercher': 'Rechercher',
      'reessayer': 'Réessayer',
      'renvoyerLeCode': 'Renvoyer le code',
      'reservation100Digitale': 'Réservation 100% digitale',
      'retour': 'Retour',
      'retourALaccueil': "Retour à l'accueil",
      'seConnecter': 'Se Connecter',
      'seConnecter2': 'Se connecter',
      'seDeconnecter': 'Se déconnecter',
      'selectionnezAuMoinsUnTypeDe':
          'Sélectionnez au moins un type de véhicule',
      'selectionnezVotrePlaqueDimmatriculation':
          "Selectionnez votre plaque d'immatriculation",
      'signalerUnProbleme': 'Signaler un problème',
      'stationnerIci': 'Stationner ici',
      'suivant': 'Suivant',
      'supprimer': 'Supprimer',
      'supprimerLeCompte': 'Supprimer le compte',
      'tarif': 'Tarif',
      'tarifsEtHoraires': 'Tarifs et horaires',
      'telechargezLesDocumentsLegalisesDeLa':
          'Téléchargez les documents légalisés de la\nmunicipalité pour valider votre emplacement',
      'telechargezUnDocument': 'Téléchargez un document',
      'text5dtmois': '5DT / mois',
      'titre': 'Titre',
      'trustpilot': 'Trustpilot',
      'tuniparkV100': 'Tunipark v1.0.0',
      'typeDeVehicule': 'Type de véhicule',
      'validite': 'Validité',
      'vehiculeElectrique': 'Véhicule électrique',
      'version101erJanvier2025': 'Version 1.0 — 1er janvier 2025',
      'veuillezPatienter': 'Veuillez patienter',
      'voirLaDisponibilite': 'Voir la disponibilité',
      'voirLesAutresPhotos': 'Voir les autres photos',
      'votreCompteAEteCreeAvec':
          'Votre compte a été créé avec succès.\nVous pouvez maintenant commencer à utiliser TuniPark.',
      'votreEspaceEstDesormaisVisiblePar':
          'Votre espace est désormais visible par '
          'les conducteurs. Vous serez notifié dès\n'
          'qu’une réservation est effectuée.',
      'votreMotDePasseAEte':
          'Votre mot de passe a été modifié '
          'avec succès. Vous pouvez maintenant\n'
          'vous connecter',
      'vousAvezUnCompte': 'Vous avez un compte ?',
      'vousN': 'Vous n\'',
      'vousNAvezPasDeCompte': "Vous n'avez pas de compte ?",
      'vousNavezPasEncoreRecuLe': "Vous n'avez pas encore reçu le code ?",
      'yes': 'Oui',
      'appName': 'TuniPark',
      'abonnementLongueDuree': 'Abonnement longue durée',
      'aboutUs': 'À propos de nous',
      'active': 'Actif',
      'addYourParkingPlace': 'Ajoutez votre place de parking',
      'adresseEMail': 'Adresse e-mail',
      'adresseMail': 'Adresse mail',
      'aideSupport': 'Aide & support',

      'ajoutezPhotosEtDocuments': 'Ajoutez photos et documents',
      'announce': 'Annonce',
      'appareilsConnectes': 'Appareils connectés',
      'authentificationBiometrique': 'Authentification biométrique',
      'autreChose': 'Autre chose ?',
      'availability': 'Disponibilité',
      'behavior': 'Comportement',
      'bookAgain': 'Réserver à nouveau',
      'camionEtc': 'Camion -etc.',
      'carteBancaire': 'Carte bancaire',
      'centreDAide': 'Centre d\'aide',
      'changerLeMotDePasse': 'Changer le mot de passe',
      'chatEnDirect': 'Chat en direct',
      'chezTuniparkLaProtectionDeVosDonnees':
          'Chez Tunipark, la protection de vos données personnelles est une priorité. Cette politique explique comment nous collectons, utilisons et protégeons vos informations lorsque vous utilisez notre application.',
      'commencer': 'Commencer',
      'commissionTunipark': 'Commission Tunipark',
      'complet': 'Complet',
      'comportementAttendu': 'Comportement attendu',
      'compte': 'Compte',
      'conditionsPourDevenirPartenaire': 'Conditions pour devenir partenaire',
      'confirmerLeNouveauMotDePasse': 'Confirmer le nouveau mot de passe',
      'connexion': 'Connexion',
      'contact': 'Contact',
      'continuer': 'Continuer',
      'creerUnNouveauMotDePasse': 'Créer un nouveau mot de passe',
      'cryptogramme': 'Cryptogramme',
      'deconnecterTousLesAppareils': 'Déconnecter tous les appareils',
      'decrivezVotreEmplacement2': 'Décrivez votre emplacement',
      'decrivezVotreProblemeIci': 'Décrivez votre problème ici...',
      'definissezVosTarifsAuJourOuAu':
          'Définissez vos tarifs au jour ou au mois, puis publiez',
      'devenirPartenaire': 'Devenir partenaire',
      'disponibilite': 'Disponibilité',
      'distance': 'Distance',
      'duration': 'Durée',
      'duree': 'Durée :',
      'eMail': 'E-mail',
      'earnUpTo150DtPerYear': 'Gagnez jusqu\'à 150 DT par an',
      'electricRecharge': 'Recharge électrique',
      'emplacementEnPleinAirDansUneCour':
          'Emplacement en plein air, dans une cour ou sur un terrain ouvert',
      'emplacementEnPleinAirOuCourOuverte':
          'Emplacement en plein air ou cour ouverte',
      'emplacementProtegeParUneToitureOuUne':
          'Emplacement protégé par une toiture ou une structure',
      'end': 'Fin',
      'english': 'Anglais',
      'enregistrer': 'Enregistrer',
      'enregistrerLeNouveauMotDePasse': 'Enregistrer le nouveau mot de passe',
      'enregistrerLesModifications': 'Enregistrer les modifications',
      'envoyer': 'Envoyer',
      'envoyerLeCode': 'Envoyer le code',
      'envoyerLeLien': 'Envoyer le lien',
      'evaluerLApplication': 'Évaluer l\'application',
      'ex14RueDesJasminsElMenzah': 'Ex: 14 Rue des Jasmins, El Menzah 6',
      'fixezVosPrixEtPubliez': 'Fixez vos prix et publiez',
      'flouci': 'Flouci',
      'fraisDeService': 'Frais de service',
      'from': 'De',
      'garageDeMaison': 'Garage de maison',
      'garageIndividuelAttenantOuSepare':
          'Garage individuel attenant ou séparé',
      'garageIndividuelAttenantOuSepareDUne':
          'Garage individuel attenant ou séparé d\'une maison',
      'general': 'Général',
      'gererMesPlaces': 'Gérer mes places',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 -etc.',
      'grand': 'Grand',
      'haut': 'Haut',
      'hauteur19M': 'Hauteur : 1.9 m',
      'helpYourLovedOnesParkInviteUp':
          'Aidez vos proches à se garer ! Invitez jusqu\'à 5 amis par an.',
      'heureJour': 'Heure/Jour',
      'horairesDAcces': 'Horaires d\'accès',
      'identite': 'Identité',
      'indiquezLeTypeDeParkingSonAdresse':
          'Indiquez le type de parking, son adresse et ses caractéristiques',
      'informationsDeLAnnonce': 'Informations de l\'annonce',
      'informationsPersonnelles': 'Informations personnelles',
      'jour': 'Jour',
      'laissezA0PourNePasProposer':
          'Laissez à 0 pour ne pas proposer de tarif horaire',
      'largeur24M': 'Largeur : 2.4 m',
      'logIn': 'Connexion',
      'long4mLarg175mHaut1': 'Long<4m, Larg<1.75m, Haut<1.5m',
      'longueur5M': 'Longueur : 5 m',
      'manageYourPlaces': 'Gérez vos places',
      'membreDepuis': 'Membre depuis',
      'mensualite': 'Mensualité',
      'mettezAJourLAdresseSiNecessaire':
          'Mettez à jour l\'adresse si nécessaire.',
      'miseAJourDisponible': 'Mise à jour disponible',
      'modifierLEMail': 'Modifier l\'e-mail',
      'modifierLeNom': 'Modifier le nom',
      'modifierLeTelephone': 'Modifier le téléphone',
      'monProfil': 'Mon Profil',
      'month': '/ mois',
      'monthly': 'Mensuel',
      'motDePasse': 'Mot de passe',
      'motDePasseActuel': 'Mot de passe actuel',
      'motDePasseOublie2': 'Mot de passe oublié',
      'moto': 'Moto',
      'motoScooterEtc': 'Moto - Scooter -etc.',
      'moyen': 'Moyen',
      'myPersonalDetails': 'Mes informations personnelles',
      'myVehicles': 'Mes véhicules',
      'navigate': 'Itinéraire',
      'noCommitment': 'Sans\nengagement',
      'nom': 'Nom',
      'nombreDePlaces': 'Nombre de places',
      'notification': 'Notification',
      'nousAvonsEnvoyeUnLienDeReinitialisation':
          'Nous avons envoyé un lien de réinitialisation à\n23*****3.\nSaisissez le code à 6 chiffres indiqué dans le\nmessage.',
      'nousContacter': 'Nous contacter',
      'nouveauMotDePasse': 'Nouveau mot de passe',
      'nuit': 'Nuit',
      'numeroDeCarte': 'Numéro de carte',
      'numeroDeTelephone': 'Numéro de téléphone',
      'ouverture': 'Ouverture',
      'ouvertureEx0700': 'Ouverture (ex: 07:00)',
      'paid': 'Payé',
      'paiement': 'Paiement :',
      'paiement2': 'Paiement',
      'paiementConfirme': 'Paiement confirmé',
      'parMois': 'Par mois',
      'parametresDeLApp': 'Paramètres de l\'app',
      'parking': 'Parking',
      'parkingApprouve': 'Parking approuvé',
      'parkingCouvert': 'Parking couvert',
      'parkingExterieur': 'Parking extérieur',
      'partagerTunipark': 'Partager Tunipark',
      'partenaires': 'Partenaires',
      'past': 'Passées',
      'payment': 'Paiement',
      'petit': 'Petit',
      'placeDansUnParkingSouterrain': 'Place dans un parking souterrain',
      'placeDansUnParkingSouterrainDImmeuble':
          'Place dans un parking souterrain d\'immeuble résidentiel',
      'placeMoto': 'Place moto',
      'placesLibres': 'Places libres',
      'pourDesRaisonsDeSecuriteVeuillezNoter':
          'Pour des raisons de sécurité, veuillez noter un mot\nde passe peut varier',
      'pourLesVisiteursEtLesDeplacements':
          'Pour les visiteurs et les déplacements',
      'pourModifierLaPositionGpsUtilisezLa':
          'Pour modifier la position GPS, utilisez la carte dans l\'application.',
      'prenezDesPhotosClairesMontrantLemplacementLacces':
          'Prenez des photos claires montrant l’emplacement, l’accès et les environs.',
      'prenezDesPhotosEtTelechargezDesDocuments':
          'Prenez des photos et téléchargez des documents légaux de municipalité',
      'prenom': 'Prénom',
      'prixJourDt': 'Prix / jour (DT)',
      'prixMoisDt': 'Prix / mois (DT)',
      'prixMoyJour': 'Prix moy. / jour',
      'prixParHeureOptionnel': 'Prix par heure (optionnel)',
      'prixParJour': 'Prix par jour',
      'prixParMois': 'Prix par mois',
      'publier': 'Publier',
      'publiezSurTuniparkCestFacile2': 'Publiez sur TuniPark ,\nc’est facile',
      'quelTypeDEmplacement': 'Quel type d\'emplacement ?',
      'quelTypeDEmplacementProposezVous':
          'Quel type d\'emplacement\nproposez-vous ?',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 -etc.',
      'rechercherUneQuestion': 'Rechercher une question...',
      'referral': 'Parrainage',
      'rentYourParkingSpaces': 'Louez vos places de parking.',
      'reservationLongueDuree': 'Réservation longue durée',
      'reservations': 'Réservations',
      'reservations2': 'Réservations',
      'resiliationDuPartenariat': 'Résiliation du partenariat',
      'resiliationPartenariat': 'Résiliation partenariat',
      'responsabilitesDuPartenaire': 'Responsabilités du partenaire',

      'safetyInstructions': 'Consignes de sécurité',
      'saisissezVotreAdresse': 'Saisissez votre adresse',
      'saisissezVotreEMailOuNumeroDe':
          'Saisissez votre e-mail ou numéro de téléphone\npour réinitialiser le mot de passe',
      'securePrivateParking': 'Parking privé\nsécurisé',
      'securite': 'Sécurité',
      'selectEnd': 'Sélectionner la fin',
      'selectStart': 'Sélectionner le début',

      'sessionExpired': 'Session expirée',
      'sessionsActives': 'Sessions actives',
      'signOut': 'Se déconnecter',
      'signalementDAbus': 'Signalement d\'abus',
      'simpleCargoBiplaceEtc': 'Simple - Cargo - Biplace -etc.',
      'sousSolDImmeuble': 'Sous-sol d\'immeuble',
      'sousSolImmeubleEnnarjess': 'Sous-sol immeuble Ennarjess',
      'start': 'Début',
      'statut': 'Statut',
      'telephone': 'Téléphone',
      'text': 'Français',
      'text1acceptationdesconditions': '1. Acceptation des conditions',
      'text1collectedesdonnees': '1. Collecte des données',
      'text2descriptionduservice': '2. Description du service',
      'text2utilisationdesdonnees': '2. Utilisation des données',
      'text3creationdecompte': '3. Création de compte',
      'text3partagedesdonnees': '3. Partage des données',
      'text4proprieteintellectuelle': '4. Propriété intellectuelle',
      'text4securitedesdonnees': '4. Sécurité des données',
      'text5conservationdesdonnees': '5. Conservation des données',
      'text5limitationderesponsabilite': '5. Limitation de responsabilité',
      'text6modificationdesconditions': '6. Modification des conditions',
      'text6vosdroits': '6. Vos droits',
      'text7cookiesettechnologiessimilaires':
          '7. Cookies et technologies similaires',
      'text7droitapplicable': '7. Droit applicable',
      'text8caracteresminimum': '8 caractères minimum',
      'text8modificationsdecettepolitique':
          '8. Modifications de cette politique',
      'text9contact': '9. Contact',
      'titreDeLAnnonce': 'Titre de l\'annonce',
      'total': 'Total',
      'unChiffre': 'Un chiffre',
      'unCodeDeVerificationSeraEnvoyePar':
          'Un code de vérification sera envoyé par SMS pour confirmer.',
      'unLienDeConfirmationSeraEnvoyeA':
          'Un lien de confirmation sera envoyé à votre nouvelle adresse.',
      'uneLettreMajuscule': 'Une lettre majuscule',
      'until': 'Jusqu\'à',
      'utilisateurs': 'Utilisateurs',
      'vehiculesAcceptes': 'Véhicules acceptés',
      'veloTrotinette': 'Vélo/trotinette',
      'verificationEnDeuxEtapes': 'Vérification en deux étapes',
      'verifierLeCode': 'Vérifier le code',
      'verifiezVotreTelephone': 'Vérifiez votre téléphone',
      'viewReceipt': 'Voir le reçu',
      'viewSession': 'Voir la session',
      'votreNouveauMotDePasseDoitContenir':
          'Votre nouveau mot de passe doit contenir au moins 8 caractères.',
      'vousAvezUnCompte2': 'Vous avez un compte ?',
      'vousNAvezAucunParking': 'Vous n\'avez aucun parking',
      'vousNAvezPasDeCompte2': 'Vous n\'avez pas de compte ?',
      'vousNavezPasEncoreRecuLeCode': 'Vous n’avez pas encore reçu le code ?',
      'yourDedicatedSpace': 'Votre\nespace\ndédié',
      'yourSessionHasExpiredPleaseLogIn':
          'Votre session a expiré. Veuillez vous reconnecter.',
      'expiration': 'Expiration',
      'explore': 'Explorer',
      'extend': 'Prolonger',
      'sessionDetails': 'Détails de la session',
      'endSession': 'Terminer la session',
      'confirmEndSession': 'Voulez-vous vraiment terminer cette session ?',
      'vehicle': 'Véhicule',
      'plate': 'Plaque',
      'payAndExtend': 'Payer et prolonger',
      'processingPayment': 'Traitement du paiement…',
      'openingPaymentLink': 'Ouverture du lien de paiement…',
      'extendSuccess': 'Session prolongée avec succès',
      'paymentFailed': 'Paiement échoué. Veuillez réessayer.',
      'sessionEnded': 'Session terminée',
      'cantOpenMaps': 'Impossible d\'ouvrir l\'application de navigation',
      'cantOpenPaymentLink': 'Impossible d\'ouvrir le lien de paiement',
      'close': 'Fermer',
      'faqCentreDAide': 'FAQ & Centre d\'aide',
      'fermeture': 'Fermeture',
      'fermetureEx2200': 'Fermeture (ex: 22:00)',
    },

    'en': {
      'adresse': 'Address',
      'adresseDuParking': 'Parking address',
      'aiSummary': 'AI Summary',
      'ajouter': 'Add',
      'ajouterUnVehicule': 'Add a vehicle',
      'ajouterUneCarteBancaire': 'Add a bank card',
      'ajouterUnePlaqueDimmatriculation': 'Add a license plate',
      'ajoutezAuMoins3PhotosPour':
          'Add at least 3 photos to\nshowcase your parking space',
      'ajoutezDesPhotos': 'Add photos',
      'annoncePubliee': 'Listing published!',
      'annuler': 'Cancel',
      'appareilsDeconnectesAvecSucces': 'Devices disconnected successfully',
      'archiver': 'Archive',
      'archiverCeParking': 'Archive this parking?',
      'areYouSureYouWantTo':
          'Are you sure you want to cancel this reservation?',
      'aucunHistoriqueDisponible': 'No history available.',
      'aucunLieuTrouve': 'No place found',
      'aucunPaiementEffectuePourLeMoment': 'No payment made yet',
      'aucunResultatTrouve': 'No results found',
      'aucuneNotification': 'No notifications',
      'autorisationDeLaMunicipalite':
          '• Municipality authorization\n'
          '• Property title or lease agreement\n'
          '• Insurance certificate\n'
          '• Compliance certificate (if land)',
      'bestMatch': '⭐ Best Match',
      'bonjour': 'Hello 👋',
      'cancelReservation': 'Cancel reservation?',
      'capaciteHoraires': 'Capacity & opening hours',
      'caracteristiques': 'Features',
      'cetteActionEstIrreversibleVoulezVous':
          'This action is irreversible. Do you really want to delete your account?',
      'chezTuniparkLaProtectionDeVos':
          'At Tunipark, protecting your personal data is a priority.',
      'commencezASaisirUneAdresse': 'Start typing an address',
      'compatibleAvec': 'Compatible with',
      'conditionsDUtilisation': 'Terms of use',
      'confirmer': 'Confirm',
      'connectezVousPourAccederAVotre': 'Log in to access your account.',
      'creerUnCompte': 'Create an account',
      'decrivezVotreEmplacement': 'Describe your parking space',
      'definissezVosPrixVousPourrezLes':
          'Set your prices. You can change them at any time.',
      'derniereMiseAJour1erJanvier': 'Last updated: January 1, 2025',
      'description': 'Description',
      'devenezPartenaireTuniparkEtCommencezA':
          'Become a TuniPark partner and start\nearning from your garage, basement, or private space.',
      'dimensionsDeLaPlace': 'Parking space dimensions',
      'documentsLegaux': 'Legal documents',
      'dt': 'TND',
      'echecDeLaPublication': 'Publication failed',
      'editerLeProfil': 'Edit profile',
      'enAttenteDeConfirmationDuPaiement': 'Waiting for payment confirmation…',
      'enUtilisantTuniparkVousConfirmezAvoir':
          'By using Tunipark, you confirm that you have read and accepted these terms in full.',
      'entrezEtSortezDeVotreParking':
          'Enter and exit your parking without using the Tunipark app',
      'fixerVosTarifs': 'Set your prices',
      'francais': 'French',
      'gpsIsDisabledPleaseEnableLocation':
          'GPS is disabled. Please enable location.',
      'historique': 'History',
      'horairesD': 'Opening hours',
      'indiquezCombienDePlacesVousProposez':
          'Indicate how many spaces you offer, your opening hours, and accepted vehicles.',
      'informationsDeL': 'Listing information',
      'informationsMisesAJour': 'Information updated',
      'inscriptionReussie': 'Registration successful!',
      'inscrivezVousPourAccederAVotre': 'Sign up to access your account.',
      'itineraire': 'Directions',
      'laDateSelectionneeDoitEtrePosterieure':
          'The selected date must be after the minimum date.',
      'langue': 'Language',
      'locationPermissionDenied': 'Location permission denied.',
      'locationPermissionPermanentlyDeniedOpenApp':
          'Location permission permanently denied. Open app settings.',
      'mesAnnonces': 'My listings',
      'mesPaiements': 'My payments',
      'mesReservations': 'My reservations',
      'mesVehicules': 'My vehicles',
      'mettezAJourL': 'Update the',
      'mode': 'Mode',
      'modifier': 'Edit',
      'motDePasseModifieAvecSucces': 'Password changed successfully',
      'motDePasseOublie': 'Forgot password?',
      'motDePasseReinitialise': 'Password reset!',
      'no': 'No',
      'noReservationsFound': 'No reservations found',
      'notifications': 'Notifications',
      'nousContacterPourVosDroits': 'Contact us about your rights',
      'optionCarteDAcces': 'Access card option',
      'ou': 'Or',
      'ouSeSitueVotreEmplacement': 'Where is your parking space located?',
      'paiement100Securise': '100% secure payment',
      'paiementReussi': 'Payment successful!',
      'paiementSecuriseViaLApplication': 'Secure payment through the app',
      'parkingArchiveAvecSucces': 'Parking archived successfully',
      'parkingMisAJourAvecSucces': 'Parking updated successfully',
      'partager': 'Share',
      'placeVoiture': 'Car space',
      'placesDisponibles': 'Available spaces',
      'politiqueDeConfidentialite': 'Privacy policy',
      'pourModifierLaPositionGpsUtilisez':
          'To change the GPS position, use the map in the',
      'pourToutVehicule': 'For all vehicles',
      'prenezDesPhotosClairesMontrantLemplacement':
          'Take clear photos showing the space, access, and surroundings.',
      'publicationEnCours': 'Publishing…',
      'publierMonPremierParking': 'Publish my first parking',
      'publiezSurTuniparkCestFacile': 'Publishing on TuniPark is\neasy',
      'quelTypeD': 'What type of',
      'rechercher': 'Search',
      'reessayer': 'Retry',
      'renvoyerLeCode': 'Resend code',
      'reservation100Digitale': '100% digital reservation',
      'retour': 'Back',
      'retourALaccueil': 'Back to home',
      'seConnecter': 'Log in',
      'seConnecter2': 'Log in',
      'seDeconnecter': 'Log out',
      'selectionnezAuMoinsUnTypeDe': 'Select at least one vehicle type',
      'selectionnezVotrePlaqueDimmatriculation': 'Select your license plate',
      'signalerUnProbleme': 'Report a problem',
      'stationnerIci': 'Park here',
      'suivant': 'Next',
      'supprimer': 'Delete',
      'supprimerLeCompte': 'Delete account',
      'tarif': 'Price',
      'tarifsEtHoraires': 'Prices and opening hours',
      'telechargezLesDocumentsLegalisesDeLa':
          'Upload the legalized documents from the\nmunicipality to validate your space',
      'telechargezUnDocument': 'Upload a document',
      'text5dtmois': '5 TND / month',
      'titre': 'Title',
      'trustpilot': 'Trustpilot',
      'tuniparkV100': 'Tunipark v1.0.0',
      'typeDeVehicule': 'Vehicle type',
      'validite': 'Validity',
      'vehiculeElectrique': 'Electric vehicle',
      'version101erJanvier2025': 'Version 1.0 — January 1, 2025',
      'veuillezPatienter': 'Please wait',
      'voirLaDisponibilite': 'View availability',
      'voirLesAutresPhotos': 'View other photos',
      'votreCompteAEteCreeAvec':
          'Your account has been created successfully.\nYou can now start using TuniPark.',
      'votreEspaceEstDesormaisVisiblePar':
          'Your parking space is now visible to '
          'drivers. You will be notified as soon as\n'
          'a reservation is made.',
      'votreMotDePasseAEte':
          'Your password has been changed '
          'successfully. You can now\n'
          'log in',
      'vousAvezUnCompte': 'Already have an account?',
      'vousN': 'You have not',
      'vousNAvezPasDeCompte': "Don't have an account?",
      'vousNavezPasEncoreRecuLe': "Haven't received the code yet?",
      'yes': 'Yes',
      'appName': 'TuniPark',
      'abonnementLongueDuree': 'Long-term subscription',
      'aboutUs': 'About us',
      'active': 'Active',
      'addYourParkingPlace': 'Add Your Parking Place',
      'adresseEMail': 'Email address',
      'adresseMail': 'Email address',
      'aideSupport': 'Help & support',
      'ajoutezPhotosEtDocuments': 'Add photos and documents',
      'announce': 'Announce',
      'appareilsConnectes': 'Connected devices',
      'authentificationBiometrique': 'Biometric authentication',
      'autreChose': 'Anything else?',
      'availability': 'Availability',
      'behavior': 'Behavior',
      'bookAgain': 'Book again',
      'camionEtc': 'Truck - etc.',
      'carteBancaire': 'Bank card',
      'centreDAide': 'Help Center',
      'changerLeMotDePasse': 'Change password',
      'chatEnDirect': 'Live chat',
      'chezTuniparkLaProtectionDeVosDonnees':
          'At TuniPark, protecting your personal data is a priority. This policy explains how we collect, use, and protect your information when you use our application.',
      'commencer': 'Start',
      'commissionTunipark': 'TuniPark commission',
      'complet': 'Full',
      'comportementAttendu': 'Expected behavior',
      'compte': 'Account',
      'conditionsPourDevenirPartenaire': 'Requirements to become a partner',
      'confirmerLeNouveauMotDePasse': 'Confirm new password',
      'connexion': 'Login',
      'contact': 'Contact',
      'continuer': 'Continue',
      'creerUnNouveauMotDePasse': 'Create a new password',
      'cryptogramme': 'CVV',
      'deconnecterTousLesAppareils': 'Disconnect all devices',
      'decrivezVotreEmplacement2': 'Describe your parking space',
      'decrivezVotreProblemeIci': 'Describe your issue here...',
      'definissezVosTarifsAuJourOuAu':
          'Set your daily or monthly rates, then publish',
      'devenirPartenaire': 'Become a partner',
      'disponibilite': 'Availability',
      'distance': 'Distance',
      'duration': 'Duration',
      'duree': 'Duration:',
      'eMail': 'E-mail',
      'earnUpTo150DtPerYear': 'Earn up to 150 DT per year',
      'electricRecharge': 'Electric charging',
      'emplacementEnPleinAirDansUneCour':
          'Outdoor parking space in a yard or open lot',
      'emplacementEnPleinAirOuCourOuverte':
          'Outdoor parking space or open courtyard',
      'emplacementProtegeParUneToitureOuUne':
          'Parking space protected by a roof or structure',
      'end': 'End',
      'english': 'English',
      'enregistrer': 'Save',
      'enregistrerLeNouveauMotDePasse': 'Save new password',
      'enregistrerLesModifications': 'Save changes',
      'envoyer': 'Send',
      'envoyerLeCode': 'Send code',
      'envoyerLeLien': 'Send the link',
      'evaluerLApplication': 'Rate the application',
      'ex14RueDesJasminsElMenzah': 'Ex: 14 Rue des Jasmins, El Menzah 6',
      'expiration': 'Expiration',
      'explore': 'Explore',
      'extend': 'Extend',
      'faqCentreDAide': 'FAQ & Help Center',
      'fermeture': 'Closing',
      'fermetureEx2200': 'Closing (e.g. 22:00)',
      'fixezVosPrixEtPubliez': 'Set your prices and publish',
      'flouci': 'Flouci',
      'fraisDeService': 'Service fee',
      'from': 'From',
      'garageDeMaison': 'Home garage',
      'garageIndividuelAttenantOuSepare': 'Attached or detached private garage',
      'garageIndividuelAttenantOuSepareDUne':
          'Attached or detached garage of a house',
      'general': 'General',
      'gererMesPlaces': 'Manage my places',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 - etc.',
      'grand': 'Large',
      'haut': 'High',
      'hauteur19M': 'Height: 1.9 m',
      'helpYourLovedOnesParkInviteUp':
          'Help your loved ones park! Invite up to 5 friends per year.',
      'heureJour': 'Hour/Day',
      'horairesDAcces': 'Access hours',
      'identite': 'Identity',
      'indiquezLeTypeDeParkingSonAdresse':
          'Specify the parking type, address, and characteristics',
      'informationsDeLAnnonce': 'Listing information',
      'informationsPersonnelles': 'Personal information',
      'jour': 'Day',
      'laissezA0PourNePasProposer':
          'Leave at 0 if you do not want to offer an hourly rate',
      'largeur24M': 'Width: 2.4 m',
      'logIn': 'Log In',
      'long4mLarg175mHaut1': 'Length < 4 m, Width < 1.75 m, Height < 1.5 m',
      'longueur5M': 'Length: 5 m',
      'manageYourPlaces': 'Manage Your Places',
      'membreDepuis': 'Member since',
      'mensualite': 'Monthly fee',
      'mettezAJourLAdresseSiNecessaire': 'Update the address if necessary.',
      'miseAJourDisponible': 'Update available',
      'modifierLEMail': 'Edit email',
      'modifierLeNom': 'Edit name',
      'modifierLeTelephone': 'Edit phone number',
      'monProfil': 'My profile',
      'month': '/ month',
      'monthly': 'Monthly',
      'motDePasse': 'Password',
      'motDePasseActuel': 'Current password',
      'motDePasseOublie2': 'Forgot password',
      'moto': 'Motorcycle',
      'motoScooterEtc': 'Motorcycle - Scooter - etc.',
      'moyen': 'Medium',
      'myPersonalDetails': 'My personal details',
      'myVehicles': 'My vehicles',
      'navigate': 'Navigate',
      'noCommitment': 'No\ncommitment',
      'nom': 'Last name',
      'nombreDePlaces': 'Number of spaces',
      'notification': 'Notification',
      'nousAvonsEnvoyeUnLienDeReinitialisation':
          'We have sent a password reset link to\n23*****3.\nEnter the 6-digit code shown in the\nmessage.',
      'nousContacter': 'Contact us',
      'nouveauMotDePasse': 'New password',
      'nuit': 'Night',
      'numeroDeCarte': 'Card number',
      'numeroDeTelephone': 'Phone number',
      'ouverture': 'Opening',
      'ouvertureEx0700': 'Opening (e.g. 07:00)',
      'paid': 'Paid',
      'paiement': 'Payment:',
      'paiement2': 'Payment',
      'paiementConfirme': 'Payment confirmed',
      'parMois': 'Monthly',
      'parametresDeLApp': 'App settings',
      'parking': 'Parking',
      'parkingApprouve': 'Parking approved',
      'parkingCouvert': 'Covered parking',
      'parkingExterieur': 'Outdoor parking',
      'partagerTunipark': 'Share TuniPark',
      'partenaires': 'Partners',
      'past': 'Past',
      'payment': 'Payment',
      'petit': 'Small',
      'placeDansUnParkingSouterrain': 'Space in an underground parking garage',
      'placeDansUnParkingSouterrainDImmeuble':
          'Space in a residential underground parking garage',
      'placeMoto': 'Motorcycle space',
      'placesLibres': 'Free spaces',
      'pourDesRaisonsDeSecuriteVeuillezNoter':
          'For security reasons, please note that your password must be kept secure.',
      'pourLesVisiteursEtLesDeplacements': 'For visitors and short trips',
      'pourModifierLaPositionGpsUtilisezLa':
          'To change the GPS position, use the map in the application.',
      'prenezDesPhotosClairesMontrantLemplacementLacces':
          'Take clear photos showing the parking space, access, and surroundings.',
      'prenezDesPhotosEtTelechargezDesDocuments':
          'Take photos and upload legal municipal documents',
      'prenom': 'First name',
      'prixJourDt': 'Price / day (TND)',
      'prixMoisDt': 'Price / month (TND)',
      'prixMoyJour': 'Avg. price / day',
      'prixParHeureOptionnel': 'Price per hour (optional)',
      'prixParJour': 'Price per day',
      'prixParMois': 'Price per month',
      'publier': 'Publish',
      'publiezSurTuniparkCestFacile2': 'Publishing on TuniPark is easy',
      'quelTypeDEmplacement': 'What type of parking space?',
      'quelTypeDEmplacementProposezVous':
          'What type of parking space\ndo you offer?',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 - etc.',
      'rechercherUneQuestion': 'Search a question...',
      'referral': 'Referral',
      'rentYourParkingSpaces': 'Rent your parking spaces.',
      'reservationLongueDuree': 'Long-term reservation',
      'reservations': 'Reservations',
      'reservations2': 'Reservations',
      'resiliationDuPartenariat': 'Partnership termination',
      'resiliationPartenariat': 'Terminate partnership',
      'responsabilitesDuPartenaire': 'Partner responsibilities',
      'safetyInstructions': 'Safety instructions',
      'saisissezVotreAdresse': 'Enter your address',
      'saisissezVotreEMailOuNumeroDe':
          'Enter your email or phone number\nto reset your password',
      'securePrivateParking': 'Secure private\nparking',
      'securite': 'Security',
      'selectEnd': 'Select end',
      'selectStart': 'Select start',
      'sessionExpired': 'Session Expired',
      'sessionsActives': 'Active sessions',
      'signOut': 'Sign out',
      'signalementDAbus': 'Abuse report',
      'simpleCargoBiplaceEtc': 'Single - Cargo - Two-seater - etc.',
      'sousSolDImmeuble': 'Building basement',
      'sousSolImmeubleEnnarjess': 'Ennarjess building basement',
      'start': 'Start',
      'statut': 'Status',
      'telephone': 'Phone',
      'text': 'Arabic',
      'text1acceptationdesconditions': '1. Acceptance of Terms',
      'text1collectedesdonnees': '1. Data Collection',
      'text2descriptionduservice': '2. Service Description',
      'text2utilisationdesdonnees': '2. Use of Data',
      'text3creationdecompte': '3. Account Creation',
      'text3partagedesdonnees': '3. Data Sharing',
      'text4proprieteintellectuelle': '4. Intellectual Property',
      'text4securitedesdonnees': '4. Data Security',
      'text5conservationdesdonnees': '5. Data Retention',
      'text5limitationderesponsabilite': '5. Limitation of Liability',
      'text6modificationdesconditions': '6. Modification of Terms',
      'text6vosdroits': '6. Your Rights',
      'text7cookiesettechnologiessimilaires':
          '7. Cookies and Similar Technologies',
      'text7droitapplicable': '7. Governing Law',
      'text8caracteresminimum': 'Minimum 8 characters',
      'text8modificationsdecettepolitique': '8. Changes to this Privacy Policy',
      'text9contact': '9. Contact',
      'titreDeLAnnonce': 'Listing title',
      'total': 'Total',
      'unChiffre': 'One number',
      'unCodeDeVerificationSeraEnvoyePar':
          'A verification code will be sent by SMS for confirmation.',
      'unLienDeConfirmationSeraEnvoyeA':
          'A confirmation link will be sent to your new email address.',
      'uneLettreMajuscule': 'One uppercase letter',
      'until': 'Until',
      'utilisateurs': 'Users',
      'vehiculesAcceptes': 'Accepted vehicles',
      'veloTrotinette': 'Bicycle / Scooter',
      'verificationEnDeuxEtapes': 'Two-step verification',
      'verifierLeCode': 'Verify code',
      'verifiezVotreTelephone': 'Check your phone',
      'viewReceipt': 'View receipt',
      'viewSession': 'View session',
      'votreNouveauMotDePasseDoitContenir':
          'Your new password must contain at least 8 characters.',
      'vousAvezUnCompte2': 'Already have an account?',
      'vousNAvezAucunParking': 'You do not have any parking spaces',
      'vousNAvezPasDeCompte2': 'Don’t have an account?',
      'vousNavezPasEncoreRecuLeCode': 'Didn’t receive the code yet?',
      'yourDedicatedSpace': 'Your\ndedicated\nspace',
      'yourSessionHasExpiredPleaseLogIn':
          'Your session has expired. Please log in again.',
      'sessionDetails': 'Session details',
      'endSession': 'End session',
      'confirmEndSession': 'Are you sure you want to end this session?',
      'vehicle': 'Vehicle',
      'plate': 'Plate',
      'payAndExtend': 'Pay and extend',
      'processingPayment': 'Processing payment…',
      'openingPaymentLink': 'Opening payment link…',
      'extendSuccess': 'Session extended successfully',
      'paymentFailed': 'Payment failed. Please try again.',
      'sessionEnded': 'Session ended',
      'cantOpenMaps': 'Could not open the navigation app',
      'cantOpenPaymentLink': 'Could not open the payment link',
      'close': 'Close',
    },

    'ar': {
      'adresse': 'العنوان',
      'adresseDuParking': 'عنوان موقف السيارات',
      'aiSummary': 'ملخص الذكاء الاصطناعي',
      'ajouter': 'إضافة',
      'ajouterUnVehicule': 'إضافة مركبة',
      'ajouterUneCarteBancaire': 'إضافة بطاقة بنكية',
      'ajoutezAuMoins3PhotosPour': 'أضف 3 صور على الأقل\nلإبراز مكان الوقوف',
      'ajoutezDesPhotos': 'أضف صوراً',
      'annoncePubliee': 'تم نشر الإعلان!',
      'annuler': 'إلغاء',
      'appareilsDeconnectesAvecSucces': 'تم فصل الأجهزة بنجاح',
      'archiver': 'أرشفة',
      'archiverCeParking': 'أرشفة هذا الموقف؟',
      'areYouSureYouWantTo': 'هل أنت متأكد أنك تريد إلغاء هذا الحجز؟',
      'aucunHistoriqueDisponible': 'لا يوجد سجل متاح.',
      'aucunLieuTrouve': 'لم يتم العثور على مكان',
      'aucunPaiementEffectuePourLeMoment': 'لم يتم إجراء أي دفع حالياً',
      'aucunResultatTrouve': 'لم يتم العثور على نتائج',
      'aucuneNotification': 'لا توجد إشعارات',
      'autorisationDeLaMunicipalite':
          '• ترخيص من البلدية\n'
          '• سند ملكية أو عقد إيجار\n'
          '• شهادة تأمين\n'
          '• شهادة مطابقة (في حالة الأرض)',
      'bestMatch': '⭐ أفضل اختيار',
      'bonjour': 'مرحباً 👋',
      'cancelReservation': 'إلغاء الحجز؟',
      'capaciteHoraires': 'السعة وساعات العمل',
      'cetteActionEstIrreversibleVoulezVous':
          'هذا الإجراء لا يمكن التراجع عنه. هل تريد حقاً حذف حسابك؟',
      'chezTuniparkLaProtectionDeVos':
          'في Tunipark، حماية بياناتك الشخصية أولوية.',
      'commencezASaisirUneAdresse': 'ابدأ بكتابة العنوان',
      'compatibleAvec': 'متوافق مع',
      'connectezVousPourAccederAVotre': 'سجّل الدخول للوصول إلى حسابك.',
      'creerUnCompte': 'إنشاء حساب',
      'decrivezVotreEmplacement': 'صف مكان الوقوف الخاص بك',
      'definissezVosPrixVousPourrezLes':
          'حدد الأسعار. يمكنك تعديلها في أي وقت.',
      'derniereMiseAJour1erJanvier': 'آخر تحديث: 1 جانفي 2025',
      'devenezPartenaireTuniparkEtCommencezA':
          'كن شريكاً في TuniPark وابدأ\nفي تحقيق دخل من المرآب أو المساحة الخاصة بك.',
      'dimensionsDeLaPlace': 'أبعاد مكان الوقوف',
      'documentsLegaux': 'الوثائق القانونية',
      'dt': 'د.ت',
      'echecDeLaPublication': 'فشل النشر',
      'editerLeProfil': 'تعديل الملف الشخصي',
      'enAttenteDeConfirmationDuPaiement': 'في انتظار تأكيد الدفع…',
      'enUtilisantTuniparkVousConfirmezAvoir':
          'باستخدامك Tunipark، فإنك تؤكد أنك قرأت وقبلت هذه الشروط بالكامل.',
      'entrezEtSortezDeVotreParking':
          'ادخل واخرج من موقفك دون الحاجة لاستخدام تطبيق Tunipark',
      'fixerVosTarifs': 'تحديد الأسعار',
      'gpsIsDisabledPleaseEnableLocation': 'نظام GPS معطل. يرجى تفعيل الموقع.',
      'historique': 'السجل',
      'horairesD': 'ساعات العمل',
      'indiquezCombienDePlacesVousProposez':
          'حدد عدد الأماكن التي توفرها، وساعات العمل، وأنواع المركبات المقبولة.',
      'informationsDeL': 'معلومات الإعلان',
      'informationsMisesAJour': 'تم تحديث المعلومات',
      'inscriptionReussie': 'تم التسجيل بنجاح!',
      'inscrivezVousPourAccederAVotre': 'سجّل للوصول إلى حسابك.',
      'itineraire': 'الاتجاهات',
      'laDateSelectionneeDoitEtrePosterieure':
          'يجب أن يكون التاريخ المحدد بعد التاريخ الأدنى.',
      'locationPermissionDenied': 'تم رفض إذن الموقع.',
      'locationPermissionPermanentlyDeniedOpenApp':
          'تم رفض إذن الموقع نهائياً. افتح إعدادات التطبيق.',
      'mesAnnonces': 'إعلاناتي',
      'mesReservations': 'حجوزاتي',
      'mesVehicules': 'مركباتي',
      'mettezAJourL': 'قم بتحديث',
      'mode': 'الوضع',
      'modifier': 'تعديل',
      'motDePasseModifieAvecSucces': 'تم تغيير كلمة المرور بنجاح',
      'motDePasseOublie': 'نسيت كلمة المرور؟',
      'motDePasseReinitialise': 'تمت إعادة تعيين كلمة المرور!',
      'no': 'لا',
      'nousContacterPourVosDroits': 'تواصل معنا بخصوص حقوقك',
      'optionCarteDAcces': 'خيار بطاقة الدخول',
      'ou': 'أو',
      'ouSeSitueVotreEmplacement': 'أين يوجد مكان الوقوف الخاص بك؟',
      'paiement100Securise': 'دفع آمن 100%',
      'paiementReussi': 'تم الدفع بنجاح!',
      'paiementSecuriseViaLApplication': 'دفع آمن عبر التطبيق',
      'parkingArchiveAvecSucces': 'تمت أرشفة الموقف بنجاح',
      'parkingMisAJourAvecSucces': 'تم تحديث الموقف بنجاح',
      'partager': 'مشاركة',
      'placesDisponibles': 'الأماكن المتاحة',
      'pourModifierLaPositionGpsUtilisez': 'لتغيير موقع GPS، استخدم الخريطة في',
      'pourToutVehicule': 'لكل المركبات',
      'prenezDesPhotosClairesMontrantLemplacement':
          'التقط صوراً واضحة تُظهر المكان والمدخل والمحيط.',
      'publicationEnCours': 'جاري النشر…',
      'publierMonPremierParking': 'نشر أول موقف لي',
      'publiezSurTuniparkCestFacile': 'النشر على TuniPark\nسهل',
      'quelTypeD': 'ما نوع',
      'reessayer': 'إعادة المحاولة',
      'renvoyerLeCode': 'إعادة إرسال الرمز',
      'reservation100Digitale': 'حجز رقمي 100%',
      'seDeconnecter': 'تسجيل الخروج',
      'selectionnezAuMoinsUnTypeDe': 'اختر نوع مركبة واحداً على الأقل',
      'stationnerIci': 'اركن هنا',
      'supprimer': 'حذف',
      'tarif': 'السعر',
      'tarifsEtHoraires': 'الأسعار وساعات العمل',
      'telechargezLesDocumentsLegalisesDeLa':
          'قم بتحميل الوثائق القانونية من\nالبلدية للتحقق من مكان الوقوف',
      'telechargezUnDocument': 'تحميل وثيقة',
      'text5dtmois': '5 د.ت / شهر',
      'titre': 'العنوان',
      'trustpilot': 'Trustpilot',
      'tuniparkV100': 'Tunipark v1.0.0',
      'typeDeVehicule': 'نوع المركبة',
      'validite': 'الصلاحية',
      'vehiculeElectrique': 'مركبة كهربائية',
      'version101erJanvier2025': 'الإصدار 1.0 — 1 جانفي 2025',
      'veuillezPatienter': 'يرجى الانتظار',
      'voirLaDisponibilite': 'عرض التوفر',
      'voirLesAutresPhotos': 'عرض الصور الأخرى',
      'votreCompteAEteCreeAvec':
          'تم إنشاء حسابك بنجاح.\nيمكنك الآن البدء في استخدام TuniPark.',
      'votreEspaceEstDesormaisVisiblePar':
          'أصبح مكان الوقوف الخاص بك مرئياً الآن '
          'للسائقين. سيتم إشعارك فور\n'
          'إجراء أي حجز.',
      'votreMotDePasseAEte':
          'تم تغيير كلمة المرور الخاصة بك '
          'بنجاح. يمكنك الآن\n'
          'تسجيل الدخول',
      'vousAvezUnCompte': 'هل لديك حساب؟',
      'vousN': 'أنت لم',
      'vousNAvezPasDeCompte': 'ليس لديك حساب؟',
      'vousNavezPasEncoreRecuLe': 'لم يصلك الرمز بعد؟',
      'yes': 'نعم',
      'appName': 'TuniPark',
      'abonnementLongueDuree': 'اشتراك طويل المدى',
      'aboutUs': 'من نحن',
      'active': 'نشط',
      'addYourParkingPlace': 'أضف مكان وقوفك',
      'adresseEMail': 'البريد الإلكتروني',
      'adresseMail': 'البريد الإلكتروني',
      'aideSupport': 'المساعدة والدعم',
      'ajouterUnePlaqueDimmatriculation': 'إضافة لوحة ترقيم',
      'ajoutezPhotosEtDocuments': 'أضف صورًا ووثائق',
      'announce': 'إعلان',
      'appareilsConnectes': 'الأجهزة المتصلة',
      'authentificationBiometrique': 'المصادقة البيومترية',
      'autreChose': 'هل من شيء آخر؟',
      'availability': 'التوفر',
      'behavior': 'السلوك',
      'bookAgain': 'احجز مرة أخرى',
      'camionEtc': 'شاحنة - إلخ.',
      'caracteristiques': 'الخصائص',
      'carteBancaire': 'بطاقة بنكية',
      'centreDAide': 'مركز المساعدة',
      'changerLeMotDePasse': 'تغيير كلمة المرور',
      'chatEnDirect': 'الدردشة المباشرة',
      'chezTuniparkLaProtectionDeVosDonnees':
          'في Tunipark، حماية بياناتك الشخصية تمثل أولوية. توضح هذه السياسة كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتك عند استخدامك لتطبيقنا.',
      'commencer': 'ابدأ',
      'commissionTunipark': 'عمولة Tunipark',
      'complet': 'ممتلئ',
      'comportementAttendu': 'السلوك المتوقع',
      'compte': 'الحساب',
      'conditionsDUtilisation': 'شروط الاستخدام',
      'conditionsPourDevenirPartenaire': 'شروط أن تصبح شريكاً',
      'confirmer': 'تأكيد',
      'confirmerLeNouveauMotDePasse': 'تأكيد كلمة المرور الجديدة',
      'connexion': 'تسجيل الدخول',
      'contact': 'الاتصال',
      'continuer': 'متابعة',
      'creerUnNouveauMotDePasse': 'إنشاء كلمة مرور جديدة',
      'cryptogramme': 'رمز التحقق',
      'deconnecterTousLesAppareils': 'فصل جميع الأجهزة',
      'decrivezVotreEmplacement2': 'صف مكانك',
      'decrivezVotreProblemeIci': 'صف مشكلتك هنا...',
      'definissezVosTarifsAuJourOuAu': 'حدد أسعارك باليوم أو بالشهر، ثم انشر',
      'description': 'الوصف',
      'devenirPartenaire': 'كن شريكاً',
      'disponibilite': 'التوفر',
      'distance': 'المسافة',
      'duration': 'المدة',
      'duree': 'المدة:',
      'eMail': 'البريد الإلكتروني',
      'earnUpTo150DtPerYear': 'اكسب حتى 150 د.ت في السنة',
      'electricRecharge': 'شحن كهربائي',
      'emplacementEnPleinAirDansUneCour':
          'مكان في الهواء الطلق، في باحة أو أرض مفتوحة',
      'emplacementEnPleinAirOuCourOuverte':
          'مكان في الهواء الطلق أو باحة مفتوحة',
      'emplacementProtegeParUneToitureOuUne': 'مكان محمي بسقف أو هيكل',
      'end': 'النهاية',
      'english': 'الإنجليزية',
      'enregistrer': 'حفظ',
      'enregistrerLeNouveauMotDePasse': 'حفظ كلمة المرور الجديدة',
      'enregistrerLesModifications': 'حفظ التعديلات',
      'envoyer': 'إرسال',
      'envoyerLeCode': 'إرسال الرمز',
      'envoyerLeLien': 'إرسال الرابط',
      'evaluerLApplication': 'تقييم التطبيق',
      'ex14RueDesJasminsElMenzah': 'مثال: 14 نهج الياسمين، المنزه 6',
      'expiration': 'تاريخ الانتهاء',
      'explore': 'استكشاف',
      'extend': 'تمديد',
      'faqCentreDAide': 'الأسئلة الشائعة ومركز المساعدة',
      'fermeture': 'الإغلاق',
      'fermetureEx2200': 'وقت الغلق (مثال: 22:00)',
      'fixezVosPrixEtPubliez': 'حدد أسعارك وانشر',
      'flouci': 'Flouci',
      'fraisDeService': 'رسوم الخدمة',
      'francais': 'الفرنسية',
      'from': 'من',
      'garageDeMaison': 'كراج منزل',
      'garageIndividuelAttenantOuSepare': 'كراج فردي ملاصق أو منفصل',
      'garageIndividuelAttenantOuSepareDUne': 'كراج فردي ملاصق أو منفصل لمنزل',
      'general': 'عام',
      'gererMesPlaces': 'إدارة أماكني',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 - إلخ.',
      'grand': 'كبير',
      'haut': 'مرتفع',
      'hauteur19M': 'الارتفاع: 1.9 م',
      'helpYourLovedOnesParkInviteUp':
          'ساعد أحبابك على إيجاد موقف! ادعُ حتى 5 أصدقاء في السنة.',
      'heureJour': 'ساعة/يوم',
      'horairesDAcces': 'مواعيد الدخول',
      'identite': 'الهوية',
      'indiquezLeTypeDeParkingSonAdresse': 'حدد نوع الموقف وعنوانه وخصائصه',
      'informationsDeLAnnonce': 'معلومات الإعلان',
      'informationsPersonnelles': 'المعلومات الشخصية',
      'jour': 'اليوم',
      'laissezA0PourNePasProposer': 'اتركه عند 0 لعدم اقتراح سعر بالساعة',
      'langue': 'اللغة',
      'largeur24M': 'العرض: 2.4 م',
      'logIn': 'تسجيل الدخول',
      'long4mLarg175mHaut1': 'الطول<4م، العرض<1.75م، الارتفاع<1.5م',
      'longueur5M': 'الطول: 5 م',
      'manageYourPlaces': 'إدارة أماكنك',
      'membreDepuis': 'عضو منذ',
      'mensualite': 'المعلوم الشهري',
      'mesPaiements': 'مدفوعاتي',
      'mettezAJourLAdresseSiNecessaire': 'حدّث العنوان إذا لزم الأمر.',
      'miseAJourDisponible': 'تحديث متوفر',
      'modifierLEMail': 'تعديل البريد الإلكتروني',
      'modifierLeNom': 'تعديل الاسم',
      'modifierLeTelephone': 'تعديل رقم الهاتف',
      'monProfil': 'ملفي الشخصي',
      'month': '/ شهر',
      'monthly': 'شهرياً',
      'motDePasse': 'كلمة المرور',
      'motDePasseActuel': 'كلمة المرور الحالية',
      'motDePasseOublie2': 'نسيت كلمة المرور',
      'moto': 'دراجة نارية',
      'motoScooterEtc': 'دراجة نارية - سكوتر - إلخ.',
      'moyen': 'متوسط',
      'myPersonalDetails': 'معلوماتي الشخصية',
      'myVehicles': 'مركباتي',
      'navigate': 'الاتجاهات',
      'noCommitment': 'بدون\nالتزام',
      'noReservationsFound': 'لا توجد حجوزات',
      'nom': 'اللقب',
      'nombreDePlaces': 'عدد الأماكن',
      'notification': 'الإشعارات',
      'notifications': 'الإشعارات',
      'nousAvonsEnvoyeUnLienDeReinitialisation':
          'أرسلنا رابط إعادة تعيين إلى\n23*****3.\nأدخل الرمز المكون من 6 أرقام\nالمذكور في الرسالة.',
      'nousContacter': 'اتصل بنا',
      'nouveauMotDePasse': 'كلمة المرور الجديدة',
      'nuit': 'الليل',
      'numeroDeCarte': 'رقم البطاقة',
      'numeroDeTelephone': 'رقم الهاتف',
      'ouverture': 'الفتح',
      'ouvertureEx0700': 'وقت الفتح (مثال: 07:00)',
      'paid': 'مدفوع',
      'paiement': 'الدفع:',
      'paiement2': 'الدفع',
      'paiementConfirme': 'تم تأكيد الدفع',
      'parMois': 'شهرياً',
      'parametresDeLApp': 'إعدادات التطبيق',
      'parking': 'موقف',
      'parkingApprouve': 'تم قبول الموقف',
      'parkingCouvert': 'موقف مغطى',
      'parkingExterieur': 'موقف خارجي',
      'partagerTunipark': 'مشاركة Tunipark',
      'partenaires': 'الشركاء',
      'past': 'السابق',
      'payment': 'الدفع',
      'petit': 'صغير',
      'placeDansUnParkingSouterrain': 'مكان في موقف تحت أرضي',
      'placeDansUnParkingSouterrainDImmeuble':
          'مكان في موقف تحت أرضي لعمارة سكنية',
      'placeMoto': 'مكان دراجة نارية',
      'placeVoiture': 'مكان سيارة',
      'placesLibres': 'الأماكن الشاغرة',
      'politiqueDeConfidentialite': 'سياسة الخصوصية',
      'pourDesRaisonsDeSecuriteVeuillezNoter':
          'لأسباب أمنية، يرجى ملاحظة أن كلمة\nالمرور قد تختلف',
      'pourLesVisiteursEtLesDeplacements': 'للزوار والتنقلات',
      'pourModifierLaPositionGpsUtilisezLa':
          'لتعديل موقع GPS، استخدم الخريطة في التطبيق.',
      'prenezDesPhotosClairesMontrantLemplacementLacces':
          'التقط صوراً واضحة تُظهر المكان والمدخل والمحيط.',
      'prenezDesPhotosEtTelechargezDesDocuments':
          'التقط صوراً وحمّل الوثائق القانونية من البلدية',
      'prenom': 'الاسم',
      'prixJourDt': 'السعر / اليوم (د.ت)',
      'prixMoisDt': 'السعر / الشهر (د.ت)',
      'prixMoyJour': 'متوسط السعر / اليوم',
      'prixParHeureOptionnel': 'السعر في الساعة (اختياري)',
      'prixParJour': 'السعر في اليوم',
      'prixParMois': 'السعر في الشهر',
      'publier': 'نشر',
      'publiezSurTuniparkCestFacile2': 'انشر على TuniPark،\nالأمر سهل',
      'quelTypeDEmplacement': 'ما نوع المكان؟',
      'quelTypeDEmplacementProposezVous': 'ما نوع المكان\nالذي تقترحه؟',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 - إلخ.',
      'rechercher': 'بحث',
      'rechercherUneQuestion': 'ابحث عن سؤال...',
      'referral': 'الإحالة',
      'rentYourParkingSpaces': 'أكرِ أماكن وقوفك.',
      'reservationLongueDuree': 'حجز طويل المدى',
      'reservations': 'الحجوزات',
      'reservations2': 'الحجوزات',
      'resiliationDuPartenariat': 'إنهاء الشراكة',
      'resiliationPartenariat': 'إنهاء الشراكة',
      'responsabilitesDuPartenaire': 'مسؤوليات الشريك',
      'retour': 'رجوع',
      'retourALaccueil': 'العودة إلى الرئيسية',
      'safetyInstructions': 'تعليمات السلامة',
      'saisissezVotreAdresse': 'أدخل عنوانك',
      'saisissezVotreEMailOuNumeroDe':
          'أدخل بريدك الإلكتروني أو رقم هاتفك\nلإعادة تعيين كلمة المرور',
      'seConnecter': 'تسجيل الدخول',
      'securePrivateParking': 'موقف خاص\nآمن',
      'securite': 'الأمان',
      'selectEnd': 'اختر النهاية',
      'selectStart': 'اختر البداية',
      'selectionnezVotrePlaqueDimmatriculation': 'اختر لوحة ترقيمك',
      'sessionExpired': 'انتهت الجلسة',
      'sessionsActives': 'الجلسات النشطة',
      'signOut': 'تسجيل الخروج',
      'signalementDAbus': 'الإبلاغ عن تجاوز',
      'signalerUnProbleme': 'الإبلاغ عن مشكلة',
      'simpleCargoBiplaceEtc': 'بسيطة - حمولة - ذات مقعدين - إلخ.',
      'sousSolDImmeuble': 'الطابق السفلي لعمارة',
      'sousSolImmeubleEnnarjess': 'الطابق السفلي لعمارة النارجس',
      'start': 'البداية',
      'statut': 'الحالة',
      'suivant': 'التالي',
      'supprimerLeCompte': 'حذف الحساب',
      'telephone': 'الهاتف',
      'text': 'العربية',
      'text1acceptationdesconditions': '1. قبول الشروط',
      'text1collectedesdonnees': '1. جمع البيانات',
      'text2descriptionduservice': '2. وصف الخدمة',
      'text2utilisationdesdonnees': '2. استخدام البيانات',
      'text3creationdecompte': '3. إنشاء الحساب',
      'text3partagedesdonnees': '3. مشاركة البيانات',
      'text4proprieteintellectuelle': '4. الملكية الفكرية',
      'text4securitedesdonnees': '4. أمان البيانات',
      'text5conservationdesdonnees': '5. الاحتفاظ بالبيانات',
      'text5limitationderesponsabilite': '5. تحديد المسؤولية',
      'text6modificationdesconditions': '6. تعديل الشروط',
      'text6vosdroits': '6. حقوقك',
      'text7cookiesettechnologiessimilaires':
          '7. ملفات تعريف الارتباط والتقنيات المماثلة',
      'text7droitapplicable': '7. القانون المعمول به',
      'text8caracteresminimum': '8 أحرف على الأقل',
      'text8modificationsdecettepolitique': '8. التعديلات على هذه السياسة',
      'text9contact': '9. الاتصال',
      'titreDeLAnnonce': 'عنوان الإعلان',
      'total': 'المجموع',
      'unChiffre': 'رقم واحد',
      'unCodeDeVerificationSeraEnvoyePar':
          'سيتم إرسال رمز تحقق عبر الرسائل القصيرة للتأكيد.',
      'unLienDeConfirmationSeraEnvoyeA':
          'سيتم إرسال رابط تأكيد إلى عنوانك الجديد.',
      'uneLettreMajuscule': 'حرف كبير واحد',
      'until': 'إلى',
      'utilisateurs': 'المستخدمون',
      'vehiculesAcceptes': 'المركبات المقبولة',
      'veloTrotinette': 'دراجة هوائية/سكوتر',
      'verificationEnDeuxEtapes': 'التحقق بخطوتين',
      'verifierLeCode': 'التحقق من الرمز',
      'verifiezVotreTelephone': 'تحقق من هاتفك',
      'viewReceipt': 'عرض الوصل',
      'viewSession': 'عرض الجلسة',
      'votreNouveauMotDePasseDoitContenir':
          'يجب أن تحتوي كلمة مرورك الجديدة على 8 أحرف على الأقل.',
      'vousAvezUnCompte2': 'هل لديك حساب؟',
      'vousNAvezAucunParking': 'لا تملك أي موقف',
      'vousNAvezPasDeCompte2': 'ليس لديك حساب؟',
      'vousNavezPasEncoreRecuLeCode': 'لم تستلم الرمز بعد؟',
      'yourDedicatedSpace': 'مكانك\nالمخصص',
      'yourSessionHasExpiredPleaseLogIn':
          'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.',
      'sessionDetails': 'تفاصيل الجلسة',
      'endSession': 'إنهاء الجلسة',
      'confirmEndSession': 'هل أنت متأكد أنك تريد إنهاء هذه الجلسة؟',
      'vehicle': 'المركبة',
      'plate': 'رقم اللوحة',
      'payAndExtend': 'الدفع والتمديد',
      'processingPayment': 'جاري معالجة الدفع…',
      'openingPaymentLink': 'جاري فتح رابط الدفع…',
      'extendSuccess': 'تم تمديد الجلسة بنجاح',
      'paymentFailed': 'فشلت عملية الدفع. حاول مرة أخرى.',
      'sessionEnded': 'تم إنهاء الجلسة',
      'cantOpenMaps': 'تعذر فتح تطبيق التنقل',
      'cantOpenPaymentLink': 'تعذر فتح رابط الدفع',
      'close': 'إغلاق',
    },
  };

  // Getters
  static String get appName => _t('appName');
  static String get adresse => _t('adresse');
  static String get adresseDuParking => _t('adresseDuParking');
  static String get aiSummary => _t('aiSummary');
  static String get ajouter => _t('ajouter');
  static String get ajouterUnVehicule => _t('ajouterUnVehicule');
  static String get ajouterUneCarteBancaire => _t('ajouterUneCarteBancaire');
  static String get ajouterUnePlaqueDimmatriculation =>
      _t('ajouterUnePlaqueDimmatriculation');
  static String get ajoutezAuMoins3PhotosPour =>
      _t('ajoutezAuMoins3PhotosPour');
  static String get ajoutezDesPhotos => _t('ajoutezDesPhotos');
  static String get annoncePubliee => _t('annoncePubliee');
  static String get annuler => _t('annuler');
  static String get appareilsDeconnectesAvecSucces =>
      _t('appareilsDeconnectesAvecSucces');
  static String get archiver => _t('archiver');
  static String get archiverCeParking => _t('archiverCeParking');
  static String get areYouSureYouWantTo => _t('areYouSureYouWantTo');
  static String get aucunHistoriqueDisponible =>
      _t('aucunHistoriqueDisponible');
  static String get aucunLieuTrouve => _t('aucunLieuTrouve');
  static String get aucunPaiementEffectuePourLeMoment =>
      _t('aucunPaiementEffectuePourLeMoment');
  static String get aucunResultatTrouve => _t('aucunResultatTrouve');
  static String get aucuneNotification => _t('aucuneNotification');
  static String get autorisationDeLaMunicipalite =>
      _t('autorisationDeLaMunicipalite');
  static String get bestMatch => _t('bestMatch');
  static String get bonjour => _t('bonjour');
  static String get cancelReservation => _t('cancelReservation');
  static String get capaciteHoraires => _t('capaciteHoraires');
  static String get caracteristiques => _t('caracteristiques');
  static String get cetteActionEstIrreversibleVoulezVous =>
      _t('cetteActionEstIrreversibleVoulezVous');
  static String get chezTuniparkLaProtectionDeVos =>
      _t('chezTuniparkLaProtectionDeVos');
  static String get commencezASaisirUneAdresse =>
      _t('commencezASaisirUneAdresse');
  static String get compatibleAvec => _t('compatibleAvec');
  static String get conditionsDUtilisation => _t('conditionsDUtilisation');
  static String get confirmer => _t('confirmer');
  static String get connectezVousPourAccederAVotre =>
      _t('connectezVousPourAccederAVotre');
  static String get creerUnCompte => _t('creerUnCompte');
  static String get decrivezVotreEmplacement => _t('decrivezVotreEmplacement');
  static String get definissezVosPrixVousPourrezLes =>
      _t('definissezVosPrixVousPourrezLes');
  static String get derniereMiseAJour1erJanvier =>
      _t('derniereMiseAJour1erJanvier');
  static String get description => _t('description');
  static String get devenezPartenaireTuniparkEtCommencezA =>
      _t('devenezPartenaireTuniparkEtCommencezA');
  static String get dimensionsDeLaPlace => _t('dimensionsDeLaPlace');
  static String get documentsLegaux => _t('documentsLegaux');
  static String get dt => _t('dt');
  static String get echecDeLaPublication => _t('echecDeLaPublication');
  static String get editerLeProfil => _t('editerLeProfil');
  static String get enAttenteDeConfirmationDuPaiement =>
      _t('enAttenteDeConfirmationDuPaiement');
  static String get enUtilisantTuniparkVousConfirmezAvoir =>
      _t('enUtilisantTuniparkVousConfirmezAvoir');
  static String get entrezEtSortezDeVotreParking =>
      _t('entrezEtSortezDeVotreParking');
  static String get fixerVosTarifs => _t('fixerVosTarifs');
  static String get francais => _t('francais');
  static String get gpsIsDisabledPleaseEnableLocation =>
      _t('gpsIsDisabledPleaseEnableLocation');
  static String get historique => _t('historique');
  static String get horairesD => _t('horairesD');
  static String get indiquezCombienDePlacesVousProposez =>
      _t('indiquezCombienDePlacesVousProposez');
  static String get informationsDeL => _t('informationsDeL');
  static String get informationsMisesAJour => _t('informationsMisesAJour');
  static String get inscriptionReussie => _t('inscriptionReussie');
  static String get inscrivezVousPourAccederAVotre =>
      _t('inscrivezVousPourAccederAVotre');
  static String get itineraire => _t('itineraire');
  static String get laDateSelectionneeDoitEtrePosterieure =>
      _t('laDateSelectionneeDoitEtrePosterieure');
  static String get langue => _t('langue');
  static String get locationPermissionDenied => _t('locationPermissionDenied');
  static String get locationPermissionPermanentlyDeniedOpenApp =>
      _t('locationPermissionPermanentlyDeniedOpenApp');
  static String get mesAnnonces => _t('mesAnnonces');
  static String get mesPaiements => _t('mesPaiements');
  static String get mesReservations => _t('mesReservations');
  static String get mesVehicules => _t('mesVehicules');
  static String get mettezAJourL => _t('mettezAJourL');
  static String get mode => _t('mode');
  static String get modifier => _t('modifier');
  static String get motDePasseModifieAvecSucces =>
      _t('motDePasseModifieAvecSucces');
  static String get motDePasseOublie => _t('motDePasseOublie');
  static String get motDePasseReinitialise => _t('motDePasseReinitialise');
  static String get no => _t('no');
  static String get noReservationsFound => _t('noReservationsFound');
  static String get notifications => _t('notifications');
  static String get nousContacterPourVosDroits =>
      _t('nousContacterPourVosDroits');
  static String get optionCarteDAcces => _t('optionCarteDAcces');
  static String get ou => _t('ou');
  static String get ouSeSitueVotreEmplacement =>
      _t('ouSeSitueVotreEmplacement');
  static String get paiement100Securise => _t('paiement100Securise');
  static String get paiementReussi => _t('paiementReussi');
  static String get paiementSecuriseViaLApplication =>
      _t('paiementSecuriseViaLApplication');
  static String get parkingArchiveAvecSucces => _t('parkingArchiveAvecSucces');
  static String get parkingMisAJourAvecSucces =>
      _t('parkingMisAJourAvecSucces');
  static String get partager => _t('partager');
  static String get placeVoiture => _t('placeVoiture');
  static String get placesDisponibles => _t('placesDisponibles');
  static String get politiqueDeConfidentialite =>
      _t('politiqueDeConfidentialite');
  static String get pourModifierLaPositionGpsUtilisez =>
      _t('pourModifierLaPositionGpsUtilisez');
  static String get pourToutVehicule => _t('pourToutVehicule');
  static String get prenezDesPhotosClairesMontrantLemplacement =>
      _t('prenezDesPhotosClairesMontrantLemplacement');
  static String get publicationEnCours => _t('publicationEnCours');
  static String get publierMonPremierParking => _t('publierMonPremierParking');
  static String get publiezSurTuniparkCestFacile =>
      _t('publiezSurTuniparkCestFacile');
  static String get quelTypeD => _t('quelTypeD');
  static String get rechercher => _t('rechercher');
  static String get reessayer => _t('reessayer');
  static String get renvoyerLeCode => _t('renvoyerLeCode');
  static String get reservation100Digitale => _t('reservation100Digitale');
  static String get retour => _t('retour');
  static String get retourALaccueil => _t('retourALaccueil');
  static String get seConnecter => _t('seConnecter');
  static String get seConnecter2 => _t('seConnecter2');
  static String get seDeconnecter => _t('seDeconnecter');
  static String get selectionnezAuMoinsUnTypeDe =>
      _t('selectionnezAuMoinsUnTypeDe');
  static String get selectionnezVotrePlaqueDimmatriculation =>
      _t('selectionnezVotrePlaqueDimmatriculation');
  static String get signalerUnProbleme => _t('signalerUnProbleme');
  static String get stationnerIci => _t('stationnerIci');
  static String get suivant => _t('suivant');
  static String get supprimer => _t('supprimer');
  static String get supprimerLeCompte => _t('supprimerLeCompte');
  static String get tarif => _t('tarif');
  static String get tarifsEtHoraires => _t('tarifsEtHoraires');
  static String get telechargezLesDocumentsLegalisesDeLa =>
      _t('telechargezLesDocumentsLegalisesDeLa');
  static String get telechargezUnDocument => _t('telechargezUnDocument');
  static String get text5dtmois => _t('text5dtmois');
  static String get titre => _t('titre');
  static String get trustpilot => _t('trustpilot');
  static String get tuniparkV100 => _t('tuniparkV100');
  static String get typeDeVehicule => _t('typeDeVehicule');
  static String get validite => _t('validite');
  static String get vehiculeElectrique => _t('vehiculeElectrique');
  static String get version101erJanvier2025 => _t('version101erJanvier2025');
  static String get veuillezPatienter => _t('veuillezPatienter');
  static String get voirLaDisponibilite => _t('voirLaDisponibilite');
  static String get voirLesAutresPhotos => _t('voirLesAutresPhotos');
  static String get votreCompteAEteCreeAvec => _t('votreCompteAEteCreeAvec');
  static String get votreEspaceEstDesormaisVisiblePar =>
      _t('votreEspaceEstDesormaisVisiblePar');
  static String get votreMotDePasseAEte => _t('votreMotDePasseAEte');
  static String get vousAvezUnCompte => _t('vousAvezUnCompte');
  static String get vousN => _t('vousN');
  static String get vousNAvezPasDeCompte => _t('vousNAvezPasDeCompte');
  static String get vousNavezPasEncoreRecuLe => _t('vousNavezPasEncoreRecuLe');
  static String get yes => _t('yes');
  static String get abonnementLongueDuree => _t('abonnementLongueDuree');
  static String get aboutUs => _t('aboutUs');
  static String get active => _t('active');
  static String get addYourParkingPlace => _t('addYourParkingPlace');
  static String get adresseEMail => _t('adresseEMail');
  static String get adresseMail => _t('adresseMail');
  static String get aideSupport => _t('aideSupport');

  static String get ajoutezPhotosEtDocuments => _t('ajoutezPhotosEtDocuments');
  static String get announce => _t('announce');
  static String get appareilsConnectes => _t('appareilsConnectes');
  static String get authentificationBiometrique =>
      _t('authentificationBiometrique');
  static String get autreChose => _t('autreChose');
  static String get availability => _t('availability');
  static String get behavior => _t('behavior');
  static String get bookAgain => _t('bookAgain');
  static String get camionEtc => _t('camionEtc');
  static String get carteBancaire => _t('carteBancaire');
  static String get centreDAide => _t('centreDAide');
  static String get changerLeMotDePasse => _t('changerLeMotDePasse');
  static String get chatEnDirect => _t('chatEnDirect');
  static String get chezTuniparkLaProtectionDeVosDonnees =>
      _t('chezTuniparkLaProtectionDeVosDonnees');
  static String get commencer => _t('commencer');
  static String get commissionTunipark => _t('commissionTunipark');
  static String get complet => _t('complet');
  static String get comportementAttendu => _t('comportementAttendu');
  static String get compte => _t('compte');
  static String get conditionsPourDevenirPartenaire =>
      _t('conditionsPourDevenirPartenaire');
  static String get confirmerLeNouveauMotDePasse =>
      _t('confirmerLeNouveauMotDePasse');
  static String get connexion => _t('connexion');
  static String get contact => _t('contact');
  static String get continuer => _t('continuer');
  static String get creerUnNouveauMotDePasse => _t('creerUnNouveauMotDePasse');
  static String get cryptogramme => _t('cryptogramme');
  static String get deconnecterTousLesAppareils =>
      _t('deconnecterTousLesAppareils');
  static String get decrivezVotreEmplacement2 =>
      _t('decrivezVotreEmplacement2');
  static String get decrivezVotreProblemeIci => _t('decrivezVotreProblemeIci');
  static String get definissezVosTarifsAuJourOuAu =>
      _t('definissezVosTarifsAuJourOuAu');
  static String get devenirPartenaire => _t('devenirPartenaire');
  static String get disponibilite => _t('disponibilite');
  static String get distance => _t('distance');
  static String get duration => _t('duration');
  static String get duree => _t('duree');
  static String get eMail => _t('eMail');
  static String get earnUpTo150DtPerYear => _t('earnUpTo150DtPerYear');
  static String get electricRecharge => _t('electricRecharge');
  static String get emplacementEnPleinAirDansUneCour =>
      _t('emplacementEnPleinAirDansUneCour');
  static String get emplacementEnPleinAirOuCourOuverte =>
      _t('emplacementEnPleinAirOuCourOuverte');
  static String get emplacementProtegeParUneToitureOuUne =>
      _t('emplacementProtegeParUneToitureOuUne');
  static String get end => _t('end');
  static String get english => _t('english');
  static String get enregistrer => _t('enregistrer');
  static String get enregistrerLeNouveauMotDePasse =>
      _t('enregistrerLeNouveauMotDePasse');
  static String get enregistrerLesModifications =>
      _t('enregistrerLesModifications');
  static String get envoyer => _t('envoyer');
  static String get envoyerLeCode => _t('envoyerLeCode');
  static String get envoyerLeLien => _t('envoyerLeLien');
  static String get evaluerLApplication => _t('evaluerLApplication');
  static String get ex14RueDesJasminsElMenzah =>
      _t('ex14RueDesJasminsElMenzah');
  static String get expiration => _t('expiration');
  static String get explore => _t('explore');
  static String get extend => _t('extend');
  static String get faqCentreDAide => _t('faqCentreDAide');
  static String get fermeture => _t('fermeture');
  static String get fermetureEx2200 => _t('fermetureEx2200');
  static String get fixezVosPrixEtPubliez => _t('fixezVosPrixEtPubliez');
  static String get flouci => _t('flouci');
  static String get fraisDeService => _t('fraisDeService');
  static String get from => _t('from');
  static String get garageDeMaison => _t('garageDeMaison');
  static String get garageIndividuelAttenantOuSepare =>
      _t('garageIndividuelAttenantOuSepare');
  static String get garageIndividuelAttenantOuSepareDUne =>
      _t('garageIndividuelAttenantOuSepareDUne');
  static String get general => _t('general');
  static String get gererMesPlaces => _t('gererMesPlaces');
  static String get golfPoloPeugeot308Etc => _t('golfPoloPeugeot308Etc');
  static String get grand => _t('grand');
  static String get haut => _t('haut');
  static String get hauteur19M => _t('hauteur19M');
  static String get helpYourLovedOnesParkInviteUp =>
      _t('helpYourLovedOnesParkInviteUp');
  static String get heureJour => _t('heureJour');
  static String get horairesDAcces => _t('horairesDAcces');
  static String get identite => _t('identite');
  static String get indiquezLeTypeDeParkingSonAdresse =>
      _t('indiquezLeTypeDeParkingSonAdresse');
  static String get informationsDeLAnnonce => _t('informationsDeLAnnonce');
  static String get informationsPersonnelles => _t('informationsPersonnelles');
  static String get jour => _t('jour');
  static String get laissezA0PourNePasProposer =>
      _t('laissezA0PourNePasProposer');
  static String get largeur24M => _t('largeur24M');
  static String get logIn => _t('logIn');
  static String get long4mLarg175mHaut1 => _t('long4mLarg175mHaut1');
  static String get longueur5M => _t('longueur5M');
  static String get manageYourPlaces => _t('manageYourPlaces');
  static String get membreDepuis => _t('membreDepuis');
  static String get mensualite => _t('mensualite');
  static String get mettezAJourLAdresseSiNecessaire =>
      _t('mettezAJourLAdresseSiNecessaire');
  static String get miseAJourDisponible => _t('miseAJourDisponible');
  static String get modifierLEMail => _t('modifierLEMail');
  static String get modifierLeNom => _t('modifierLeNom');
  static String get modifierLeTelephone => _t('modifierLeTelephone');
  static String get monProfil => _t('monProfil');
  static String get month => _t('month');
  static String get monthly => _t('monthly');
  static String get motDePasse => _t('motDePasse');
  static String get motDePasseActuel => _t('motDePasseActuel');
  static String get motDePasseOublie2 => _t('motDePasseOublie2');
  static String get moto => _t('moto');
  static String get motoScooterEtc => _t('motoScooterEtc');
  static String get moyen => _t('moyen');
  static String get myPersonalDetails => _t('myPersonalDetails');
  static String get myVehicles => _t('myVehicles');
  static String get navigate => _t('navigate');
  static String get noCommitment => _t('noCommitment');
  static String get nom => _t('nom');
  static String get nombreDePlaces => _t('nombreDePlaces');
  static String get notification => _t('notification');
  static String get nousAvonsEnvoyeUnLienDeReinitialisation =>
      _t('nousAvonsEnvoyeUnLienDeReinitialisation');
  static String get nousContacter => _t('nousContacter');
  static String get nouveauMotDePasse => _t('nouveauMotDePasse');
  static String get nuit => _t('nuit');
  static String get numeroDeCarte => _t('numeroDeCarte');
  static String get numeroDeTelephone => _t('numeroDeTelephone');
  static String get ouverture => _t('ouverture');
  static String get ouvertureEx0700 => _t('ouvertureEx0700');
  static String get paid => _t('paid');
  static String get paiement => _t('paiement');
  static String get paiement2 => _t('paiement2');
  static String get paiementConfirme => _t('paiementConfirme');
  static String get parMois => _t('parMois');
  static String get parametresDeLApp => _t('parametresDeLApp');
  static String get parking => _t('parking');
  static String get parkingApprouve => _t('parkingApprouve');
  static String get parkingCouvert => _t('parkingCouvert');
  static String get parkingExterieur => _t('parkingExterieur');
  static String get partagerTunipark => _t('partagerTunipark');
  static String get partenaires => _t('partenaires');
  static String get past => _t('past');
  static String get payment => _t('payment');
  static String get petit => _t('petit');
  static String get placeDansUnParkingSouterrain =>
      _t('placeDansUnParkingSouterrain');
  static String get placeDansUnParkingSouterrainDImmeuble =>
      _t('placeDansUnParkingSouterrainDImmeuble');
  static String get placeMoto => _t('placeMoto');
  static String get placesLibres => _t('placesLibres');

  static String get pourDesRaisonsDeSecuriteVeuillezNoter =>
      _t('pourDesRaisonsDeSecuriteVeuillezNoter');
  static String get pourLesVisiteursEtLesDeplacements =>
      _t('pourLesVisiteursEtLesDeplacements');
  static String get pourModifierLaPositionGpsUtilisezLa =>
      _t('pourModifierLaPositionGpsUtilisezLa');
  static String get prenezDesPhotosClairesMontrantLemplacementLacces =>
      _t('prenezDesPhotosClairesMontrantLemplacementLacces');
  static String get prenezDesPhotosEtTelechargezDesDocuments =>
      _t('prenezDesPhotosEtTelechargezDesDocuments');
  static String get prenom => _t('prenom');
  static String get prixJourDt => _t('prixJourDt');
  static String get prixMoisDt => _t('prixMoisDt');
  static String get prixMoyJour => _t('prixMoyJour');
  static String get prixParHeureOptionnel => _t('prixParHeureOptionnel');
  static String get prixParJour => _t('prixParJour');
  static String get prixParMois => _t('prixParMois');
  static String get publier => _t('publier');
  static String get publiezSurTuniparkCestFacile2 =>
      _t('publiezSurTuniparkCestFacile2');
  static String get quelTypeDEmplacement => _t('quelTypeDEmplacement');
  static String get quelTypeDEmplacementProposezVous =>
      _t('quelTypeDEmplacementProposezVous');
  static String get rangeRoverPeugeot3008Etc => _t('rangeRoverPeugeot3008Etc');
  static String get rechercherUneQuestion => _t('rechercherUneQuestion');
  static String get referral => _t('referral');
  static String get rentYourParkingSpaces => _t('rentYourParkingSpaces');
  static String get reservationLongueDuree => _t('reservationLongueDuree');
  static String get reservations => _t('reservations');
  static String get reservations2 => _t('reservations2');
  static String get resiliationDuPartenariat => _t('resiliationDuPartenariat');
  static String get resiliationPartenariat => _t('resiliationPartenariat');
  static String get responsabilitesDuPartenaire =>
      _t('responsabilitesDuPartenaire');
  static String get safetyInstructions => _t('safetyInstructions');
  static String get saisissezVotreAdresse => _t('saisissezVotreAdresse');
  static String get saisissezVotreEMailOuNumeroDe =>
      _t('saisissezVotreEMailOuNumeroDe');
  static String get securePrivateParking => _t('securePrivateParking');
  static String get securite => _t('securite');
  static String get selectEnd => _t('selectEnd');
  static String get selectStart => _t('selectStart');

  static String get sessionExpired => _t('sessionExpired');
  static String get sessionsActives => _t('sessionsActives');
  static String get signOut => _t('signOut');
  static String get signalementDAbus => _t('signalementDAbus');
  static String get simpleCargoBiplaceEtc => _t('simpleCargoBiplaceEtc');
  static String get sousSolDImmeuble => _t('sousSolDImmeuble');
  static String get sousSolImmeubleEnnarjess => _t('sousSolImmeubleEnnarjess');
  static String get start => _t('start');
  static String get statut => _t('statut');
  static String get telephone => _t('telephone');
  static String get text => _t('text');
  static String get text1acceptationdesconditions =>
      _t('text1acceptationdesconditions');
  static String get text1collectedesdonnees => _t('text1collectedesdonnees');
  static String get text2descriptionduservice =>
      _t('text2descriptionduservice');
  static String get text2utilisationdesdonnees =>
      _t('text2utilisationdesdonnees');
  static String get text3creationdecompte => _t('text3creationdecompte');
  static String get text3partagedesdonnees => _t('text3partagedesdonnees');
  static String get text4proprieteintellectuelle =>
      _t('text4proprieteintellectuelle');
  static String get text4securitedesdonnees => _t('text4securitedesdonnees');
  static String get text5conservationdesdonnees =>
      _t('text5conservationdesdonnees');
  static String get text5limitationderesponsabilite =>
      _t('text5limitationderesponsabilite');
  static String get text6modificationdesconditions =>
      _t('text6modificationdesconditions');
  static String get text6vosdroits => _t('text6vosdroits');
  static String get text7cookiesettechnologiessimilaires =>
      _t('text7cookiesettechnologiessimilaires');
  static String get text7droitapplicable => _t('text7droitapplicable');
  static String get text8caracteresminimum => _t('text8caracteresminimum');
  static String get text8modificationsdecettepolitique =>
      _t('text8modificationsdecettepolitique');
  static String get text9contact => _t('text9contact');
  static String get titreDeLAnnonce => _t('titreDeLAnnonce');
  static String get total => _t('total');
  static String get unChiffre => _t('unChiffre');
  static String get unCodeDeVerificationSeraEnvoyePar =>
      _t('unCodeDeVerificationSeraEnvoyePar');
  static String get unLienDeConfirmationSeraEnvoyeA =>
      _t('unLienDeConfirmationSeraEnvoyeA');
  static String get uneLettreMajuscule => _t('uneLettreMajuscule');
  static String get until => _t('until');
  static String get utilisateurs => _t('utilisateurs');
  static String get vehiculesAcceptes => _t('vehiculesAcceptes');
  static String get veloTrotinette => _t('veloTrotinette');
  static String get verificationEnDeuxEtapes => _t('verificationEnDeuxEtapes');
  static String get verifierLeCode => _t('verifierLeCode');
  static String get verifiezVotreTelephone => _t('verifiezVotreTelephone');
  static String get viewReceipt => _t('viewReceipt');
  static String get viewSession => _t('viewSession');
  static String get votreNouveauMotDePasseDoitContenir =>
      _t('votreNouveauMotDePasseDoitContenir');
  static String get vousAvezUnCompte2 => _t('vousAvezUnCompte2');
  static String get vousNAvezAucunParking => _t('vousNAvezAucunParking');
  static String get vousNAvezPasDeCompte2 => _t('vousNAvezPasDeCompte2');
  static String get vousNavezPasEncoreRecuLeCode =>
      _t('vousNavezPasEncoreRecuLeCode');
  static String get yourDedicatedSpace => _t('yourDedicatedSpace');
  static String get yourSessionHasExpiredPleaseLogIn =>
      _t('yourSessionHasExpiredPleaseLogIn');
  static String get sessionDetails => _t('sessionDetails');
  static String get endSession => _t('endSession');
  static String get confirmEndSession => _t('confirmEndSession');
  static String get vehicle => _t('vehicle');
  static String get plate => _t('plate');
  static String get payAndExtend => _t('payAndExtend');
  static String get processingPayment => _t('processingPayment');
  static String get openingPaymentLink => _t('openingPaymentLink');
  static String get extendSuccess => _t('extendSuccess');
  static String get paymentFailed => _t('paymentFailed');
  static String get sessionEnded => _t('sessionEnded');
  static String get cantOpenMaps => _t('cantOpenMaps');
  static String get cantOpenPaymentLink => _t('cantOpenPaymentLink');
  static String get close => _t('close');
}
