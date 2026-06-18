abstract class AppStrings2 {
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
      'abonnementLongueDuree': 'Abonnement longue durée',
      'aboutUs': 'About us',
      'active': 'Active',
      'addYourParkingPlace': 'Add Your Parking Place',
      'adresseEMail': 'Adresse e-mail',
      'adresseMail': 'Adresse mail',
      'aideSupport': 'Aide & support',
      'ajouterUnePlaqueDimmatriculation': 'Ajouter une plaque d’immatriculation',
      'ajoutezPhotosEtDocuments': 'Ajoutez photos et documents',
      'announce': 'Announce',
      'appareilsConnectes': 'Appareils connectés',
      'authentificationBiometrique': 'Authentification biométrique',
      'autreChose': 'Autre chose ?',
      'availability': 'Availability',
      'behavior': 'Behavior',
      'bookAgain': 'Book again',
      'camionEtc': 'Camion -etc.',
      'caracteristiques': 'Caractéristiques',
      'carteBancaire': 'Carte bancaire',
      'centreDAide': 'Centre d\'aide',
      'changerLeMotDePasse': 'Changer le mot de passe',
      'chatEnDirect': 'Chat en direct',
      'chezTuniparkLaProtectionDeVosDonnees': 'Chez Tunipark, la protection de vos données personnelles est une priorité. Cette politique explique comment nous collectons, utilisons et protégeons vos informations lorsque vous utilisez notre application.',
      'commencer': 'Commencer',
      'commissionTunipark': 'Commission Tunipark',
      'complet': 'Complet',
      'comportementAttendu': 'Comportement attendu',
      'compte': 'Compte',
      'conditionsDUtilisation': 'Conditions d\'utilisation',
      'conditionsPourDevenirPartenaire': 'Conditions pour devenir partenaire',
      'confirmer': 'Confirmer',
      'confirmerLeNouveauMotDePasse': 'Confirmer le nouveau mot de passe',
      'connexion': 'Connexion',
      'contact': 'Contact',
      'continuer': 'Continuer',
      'creerUnNouveauMotDePasse': 'Créer un nouveau mot de passe',
      'cryptogramme': 'Cryptogramme',
      'deconnecterTousLesAppareils': 'Déconnecter tous les appareils',
      'decrivezVotreEmplacement': 'Décrivez votre emplacement',
      'decrivezVotreProblemeIci': 'Décrivez votre problème ici...',
      'definissezVosTarifsAuJourOuAu': 'Définissez vos tarifs au jour ou au mois, puis publiez',
      'description': 'Description',
      'devenirPartenaire': 'Devenir partenaire',
      'disponibilite': 'Disponibilité',
      'distance': 'Distance',
      'duration': 'Duration',
      'duree': 'Durée :',
      'eMail': 'E-mail',
      'earnUpTo150DtPerYear': 'Earn up to 150 DT per year',
      'electricRecharge': 'Electric recharge',
      'emplacementEnPleinAirDansUneCour': 'Emplacement en plein air, dans une cour ou sur un terrain ouvert',
      'emplacementEnPleinAirOuCourOuverte': 'Emplacement en plein air ou cour ouverte',
      'emplacementProtegeParUneToitureOuUne': 'Emplacement protégé par une toiture ou une structure',
      'end': 'End',
      'english': 'English',
      'enregistrer': 'Enregistrer',
      'enregistrerLeNouveauMotDePasse': 'Enregistrer le nouveau mot de passe',
      'enregistrerLesModifications': 'Enregistrer les modifications',
      'envoyer': 'Envoyer',
      'envoyerLeCode': 'Envoyer le code',
      'envoyerLeLien': 'Envoyer le lien',
      'evaluerLApplication': 'Évaluer l\'application',
      'ex14RueDesJasminsElMenzah': 'Ex: 14 Rue des Jasmins, El Menzah 6',
      'expiration': 'Expiration',
      'explore': 'Explore',
      'extend': 'Extend',
      'faqCentreDAide': 'FAQ & Centre d\'aide',
      'fermeture': 'Fermeture',
      'fermetureEx2200': 'Fermeture (ex: 22:00)',
      'fixezVosPrixEtPubliez': 'Fixez vos prix et publiez',
      'flouci': 'Flouci',
      'fraisDeService': 'Frais de service',
      'francais': 'Français',
      'from': 'From',
      'garageDeMaison': 'Garage de maison',
      'garageIndividuelAttenantOuSepare': 'Garage individuel attenant ou séparé',
      'garageIndividuelAttenantOuSepareDUne': 'Garage individuel attenant ou séparé d\'une maison',
      'general': 'Général',
      'gererMesPlaces': 'Gérer mes places',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 -etc.',
      'grand': 'Grand',
      'haut': 'Haut',
      'hauteur19M': 'Hauteur : 1.9 m',
      'helpYourLovedOnesParkInviteUp': 'Help your loved ones park! Invite up to 5 friends per year.',
      'heureJour': 'Heure/Jour',
      'horairesDAcces': 'Horaires d\'accès',
      'identite': 'Identité',
      'indiquezLeTypeDeParkingSonAdresse': 'Indiquez le type de parking, son adresse et ses caractéristiques',
      'informationsDeLAnnonce': 'Informations de l\'annonce',
      'informationsPersonnelles': 'Informations personnelles',
      'jour': 'Jour',
      'laissezA0PourNePasProposer': 'Laissez à 0 pour ne pas proposer de tarif horaire',
      'langue': 'Langue',
      'largeur24M': 'Largeur : 2.4 m',
      'logIn': 'Log In',
      'long4mLarg175mHaut1': 'Long<4m, Larg<1.75m, Haut<1.5m',
      'longueur5M': 'Longueur : 5 m',
      'manageYourPlaces': 'Manage Your Places',
      'membreDepuis': 'Membre depuis',
      'mensualite': 'Mensualité',
      'mesPaiements': 'Mes paiements',
      'mesVehicules': 'Mes véhicules',
      'mettezAJourLAdresseSiNecessaire': 'Mettez à jour l\'adresse si nécessaire.',
      'miseAJourDisponible': 'Mise à jour disponible',
      'mode': 'Mode',
      'modifierLEMail': 'Modifier l\'e-mail',
      'modifierLeNom': 'Modifier le nom',
      'modifierLeTelephone': 'Modifier le téléphone',
      'monProfil': 'Mon Profil',
      'month': '/ month',
      'monthly': 'Monthly',
      'motDePasse': 'Mot de passe',
      'motDePasseActuel': 'Mot de passe actuel',
      'motDePasseOublie': 'Mot de passe oublié',
      'moto': 'Moto',
      'motoScooterEtc': 'Moto - Scooter -etc.',
      'moyen': 'Moyen',
      'myPersonalDetails': 'My personal details',
      'myVehicles': 'My vehicles',
      'navigate': 'Navigate',
      'noCommitment': 'No\ncommitment',
      'noReservationsFound': 'No reservations found',
      'nom': 'Nom',
      'nombreDePlaces': 'Nombre de places',
      'notification': 'Notification',
      'notifications': 'Notifications',
      'nousAvonsEnvoyeUnLienDeReinitialisation': 'Nous avons envoyé un lien de réinitialisation à\n23*****3.\nSaisissez le code à 6 chiffres indiqué dans le\nmessage.',
      'nousContacter': 'Nous contacter',
      'nouveauMotDePasse': 'Nouveau mot de passe',
      'nuit': 'Nuit',
      'numeroDeCarte': 'Numéro de carte',
      'numeroDeTelephone': 'Numéro de téléphone',
      'ouverture': 'Ouverture',
      'ouvertureEx0700': 'Ouverture (ex: 07:00)',
      'paid': 'Paid',
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
      'past': 'Past',
      'payment': 'Payment',
      'petit': 'Petit',
      'placeDansUnParkingSouterrain': 'Place dans un parking souterrain',
      'placeDansUnParkingSouterrainDImmeuble': 'Place dans un parking souterrain d\'immeuble résidentiel',
      'placeMoto': 'Place moto',
      'placeVoiture': 'Place voiture',
      'placesLibres': 'Places libres',
      'politiqueDeConfidentialite': 'Politique de confidentialité',
      'pourDesRaisonsDeSecuriteVeuillezNoter': 'Pour des raisons de sécurité, veuillez noter un mot\nde passe peut varier',
      'pourLesVisiteursEtLesDeplacements': 'Pour les visiteurs et les déplacements',
      'pourModifierLaPositionGpsUtilisezLa': 'Pour modifier la position GPS, utilisez la carte dans l\'application.',
      'prenezDesPhotosClairesMontrantLemplacementLacces': 'Prenez des photos claires montrant l’emplacement, l’accès et les environs.',
      'prenezDesPhotosEtTelechargezDesDocuments': 'Prenez des photos et téléchargez des documents légaux de municipalité',
      'prenom': 'Prénom',
      'prixJourDt': 'Prix / jour (DT)',
      'prixMoisDt': 'Prix / mois (DT)',
      'prixMoyJour': 'Prix moy. / jour',
      'prixParHeureOptionnel': 'Prix par heure (optionnel)',
      'prixParJour': 'Prix par jour',
      'prixParMois': 'Prix par mois',
      'publier': 'Publier',
      'publiezSurTuniparkCestFacile': 'Publiez sur TuniPark ,\nc’est facile',
      'quelTypeDEmplacement': 'Quel type d\'emplacement ?',
      'quelTypeDEmplacementProposezVous': 'Quel type d\'emplacement\nproposez-vous ?',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 -etc.',
      'rechercher': 'Rechercher',
      'rechercherUneQuestion': 'Rechercher une question...',
      'referral': 'Referral',
      'rentYourParkingSpaces': 'Rent your parking spaces.',
      'reservationLongueDuree': 'Réservation longue durée',
      'reservations': 'Reservations',
      'reservations2': 'Réservations',
      'resiliationDuPartenariat': 'Résiliation du partenariat',
      'resiliationPartenariat': 'Résiliation partenariat',
      'responsabilitesDuPartenaire': 'Responsabilités du partenaire',
      'retour': 'Retour',
      'retourALaccueil': 'Retour à l’accueil',
      'safetyInstructions': 'Safety instructions',
      'saisissezVotreAdresse': 'Saisissez votre adresse',
      'saisissezVotreEMailOuNumeroDe': 'Saisissez votre e-mail ou numéro de téléphone\npour réinitialiser le mot de passe',
      'seConnecter': 'Se connecter',
      'securePrivateParking': 'Secure private\nparking',
      'securite': 'Sécurité',
      'selectEnd': 'Select end',
      'selectStart': 'Select start',
      'selectionnezVotrePlaqueDimmatriculation': 'Selectionnez votre plaque d’immatriculation',
      'sessionExpired': 'Session Expired',
      'sessionsActives': 'Sessions actives',
      'signOut': 'Sign out',
      'signalementDAbus': 'Signalement d\'abus',
      'signalerUnProbleme': 'Signaler un problème',
      'simpleCargoBiplaceEtc': 'Simple - Cargo - Biplace -etc.',
      'sousSolDImmeuble': 'Sous-sol d\'immeuble',
      'sousSolImmeubleEnnarjess': 'Sous-sol immeuble Ennarjess',
      'start': 'Start',
      'statut': 'Statut',
      'suivant': 'Suivant',
      'supprimerLeCompte': 'Supprimer le compte',
      'telephone': 'Téléphone',
      'text': 'العربية',
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
      'text7cookiesettechnologiessimilaires': '7. Cookies et technologies similaires',
      'text7droitapplicable': '7. Droit applicable',
      'text8caracteresminimum': '8 caractères minimum',
      'text8modificationsdecettepolitique': '8. Modifications de cette politique',
      'text9contact': '9. Contact',
      'titreDeLAnnonce': 'Titre de l\'annonce',
      'total': 'Total',
      'unChiffre': 'Un chiffre',
      'unCodeDeVerificationSeraEnvoyePar': 'Un code de vérification sera envoyé par SMS pour confirmer.',
      'unLienDeConfirmationSeraEnvoyeA': 'Un lien de confirmation sera envoyé à votre nouvelle adresse.',
      'uneLettreMajuscule': 'Une lettre majuscule',
      'until': 'Until',
      'utilisateurs': 'Utilisateurs',
      'vehiculesAcceptes': 'Véhicules acceptés',
      'veloTrotinette': 'Vélo/trotinette',
      'verificationEnDeuxEtapes': 'Vérification en deux étapes',
      'verifierLeCode': 'Vérifier le code',
      'verifiezVotreTelephone': 'Vérifiez votre téléphone',
      'viewReceipt': 'View receipt',
      'viewSession': 'View session',
      'votreNouveauMotDePasseDoitContenir': 'Votre nouveau mot de passe doit contenir au moins 8 caractères.',
      'vousAvezUnCompte': 'Vous avez un compte ?',
      'vousNAvezAucunParking': 'Vous n\'avez aucun parking',
      'vousNAvezPasDeCompte': 'Vous n\'avez pas de compte ?',
      'vousNavezPasEncoreRecuLeCode': 'Vous n’avez pas encore reçu le code ?',
      'yourDedicatedSpace': 'Your\ndedicated\nspace',
      'yourSessionHasExpiredPleaseLogIn': 'Your session has expired. Please log in again.',
    },

    'en': {
      'abonnementLongueDuree': 'Abonnement longue durée',
      'aboutUs': 'About us',
      'active': 'Active',
      'addYourParkingPlace': 'Add Your Parking Place',
      'adresseEMail': 'Email address',
      'adresseMail': 'Email address',
      'aideSupport': 'Help & support',
      'ajouterUnePlaqueDimmatriculation': 'Ajouter une plaque d’immatriculation',
      'ajoutezPhotosEtDocuments': 'Ajoutez photos et documents',
      'announce': 'Announce',
      'appareilsConnectes': 'Connected devices',
      'authentificationBiometrique': 'Biometric authentication',
      'autreChose': 'Autre chose ?',
      'availability': 'Availability',
      'behavior': 'Behavior',
      'bookAgain': 'Book again',
      'camionEtc': 'Camion -etc.',
      'caracteristiques': 'Caractéristiques',
      'carteBancaire': 'Bank card',
      'centreDAide': 'Centre d\'aide',
      'changerLeMotDePasse': 'Change password',
      'chatEnDirect': 'Live chat',
      'chezTuniparkLaProtectionDeVosDonnees': 'Chez Tunipark, la protection de vos données personnelles est une priorité. Cette politique explique comment nous collectons, utilisons et protégeons vos informations lorsque vous utilisez notre application.',
      'commencer': 'Start',
      'commissionTunipark': 'Commission Tunipark',
      'complet': 'Full',
      'comportementAttendu': 'Comportement attendu',
      'compte': 'Account',
      'conditionsDUtilisation': 'Conditions d\'utilisation',
      'conditionsPourDevenirPartenaire': 'Conditions pour devenir partenaire',
      'confirmer': 'Confirmer',
      'confirmerLeNouveauMotDePasse': 'Confirmer le nouveau mot de passe',
      'connexion': 'Login',
      'contact': 'Contact',
      'continuer': 'Continue',
      'creerUnNouveauMotDePasse': 'Create a new password',
      'cryptogramme': 'CVV',
      'deconnecterTousLesAppareils': 'Disconnect all devices',
      'decrivezVotreEmplacement': 'Décrivez votre emplacement',
      'decrivezVotreProblemeIci': 'Décrivez votre problème ici...',
      'definissezVosTarifsAuJourOuAu': 'Définissez vos tarifs au jour ou au mois, puis publiez',
      'description': 'Description',
      'devenirPartenaire': 'Become a partner',
      'disponibilite': 'Availability',
      'distance': 'Distance',
      'duration': 'Duration',
      'duree': 'Duration:',
      'eMail': 'E-mail',
      'earnUpTo150DtPerYear': 'Earn up to 150 DT per year',
      'electricRecharge': 'Electric recharge',
      'emplacementEnPleinAirDansUneCour': 'Emplacement en plein air, dans une cour ou sur un terrain ouvert',
      'emplacementEnPleinAirOuCourOuverte': 'Emplacement en plein air ou cour ouverte',
      'emplacementProtegeParUneToitureOuUne': 'Emplacement protégé par une toiture ou une structure',
      'end': 'End',
      'english': 'English',
      'enregistrer': 'Enregistrer',
      'enregistrerLeNouveauMotDePasse': 'Save new password',
      'enregistrerLesModifications': 'Save changes',
      'envoyer': 'Send',
      'envoyerLeCode': 'Send code',
      'envoyerLeLien': 'Envoyer le lien',
      'evaluerLApplication': 'Évaluer l\'application',
      'ex14RueDesJasminsElMenzah': 'Ex: 14 Rue des Jasmins, El Menzah 6',
      'expiration': 'Expiration',
      'explore': 'Explore',
      'extend': 'Extend',
      'faqCentreDAide': 'FAQ & Centre d\'aide',
      'fermeture': 'Closing',
      'fermetureEx2200': 'Closing (e.g. 22:00)',
      'fixezVosPrixEtPubliez': 'Fixez vos prix et publiez',
      'flouci': 'Flouci',
      'fraisDeService': 'Service fee',
      'francais': 'Français',
      'from': 'From',
      'garageDeMaison': 'Garage de maison',
      'garageIndividuelAttenantOuSepare': 'Garage individuel attenant ou séparé',
      'garageIndividuelAttenantOuSepareDUne': 'Garage individuel attenant ou séparé d\'une maison',
      'general': 'General',
      'gererMesPlaces': 'Manage my places',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 -etc.',
      'grand': 'Large',
      'haut': 'High',
      'hauteur19M': 'Hauteur : 1.9 m',
      'helpYourLovedOnesParkInviteUp': 'Help your loved ones park! Invite up to 5 friends per year.',
      'heureJour': 'Hour/Day',
      'horairesDAcces': 'Horaires d\'accès',
      'identite': 'Identité',
      'indiquezLeTypeDeParkingSonAdresse': 'Indiquez le type de parking, son adresse et ses caractéristiques',
      'informationsDeLAnnonce': 'Informations de l\'annonce',
      'informationsPersonnelles': 'Personal information',
      'jour': 'Day',
      'laissezA0PourNePasProposer': 'Laissez à 0 pour ne pas proposer de tarif horaire',
      'langue': 'Langue',
      'largeur24M': 'Largeur : 2.4 m',
      'logIn': 'Log In',
      'long4mLarg175mHaut1': 'Long<4m, Larg<1.75m, Haut<1.5m',
      'longueur5M': 'Longueur : 5 m',
      'manageYourPlaces': 'Manage Your Places',
      'membreDepuis': 'Member since',
      'mensualite': 'Monthly fee',
      'mesPaiements': 'Mes paiements',
      'mesVehicules': 'Mes véhicules',
      'mettezAJourLAdresseSiNecessaire': 'Mettez à jour l\'adresse si nécessaire.',
      'miseAJourDisponible': 'Update available',
      'mode': 'Mode',
      'modifierLEMail': 'Modifier l\'e-mail',
      'modifierLeNom': 'Edit name',
      'modifierLeTelephone': 'Edit phone number',
      'monProfil': 'My profile',
      'month': '/ month',
      'monthly': 'Monthly',
      'motDePasse': 'Password',
      'motDePasseActuel': 'Mot de passe actuel',
      'motDePasseOublie': 'Mot de passe oublié',
      'moto': 'Motorcycle',
      'motoScooterEtc': 'Moto - Scooter -etc.',
      'moyen': 'Medium',
      'myPersonalDetails': 'My personal details',
      'myVehicles': 'My vehicles',
      'navigate': 'Navigate',
      'noCommitment': 'No\ncommitment',
      'noReservationsFound': 'No reservations found',
      'nom': 'Last name',
      'nombreDePlaces': 'Number of spaces',
      'notification': 'Notification',
      'notifications': 'Notifications',
      'nousAvonsEnvoyeUnLienDeReinitialisation': 'Nous avons envoyé un lien de réinitialisation à\n23*****3.\nSaisissez le code à 6 chiffres indiqué dans le\nmessage.',
      'nousContacter': 'Contact us',
      'nouveauMotDePasse': 'Nouveau mot de passe',
      'nuit': 'Night',
      'numeroDeCarte': 'Numéro de carte',
      'numeroDeTelephone': 'Phone number',
      'ouverture': 'Opening',
      'ouvertureEx0700': 'Opening (e.g. 07:00)',
      'paid': 'Paid',
      'paiement': 'Payment:',
      'paiement2': 'Paiement',
      'paiementConfirme': 'Payment confirmed',
      'parMois': 'Monthly',
      'parametresDeLApp': 'Paramètres de l\'app',
      'parking': 'Parking',
      'parkingApprouve': 'Parking approved',
      'parkingCouvert': 'Parking couvert',
      'parkingExterieur': 'Parking extérieur',
      'partagerTunipark': 'Partager Tunipark',
      'partenaires': 'Partners',
      'past': 'Past',
      'payment': 'Payment',
      'petit': 'Small',
      'placeDansUnParkingSouterrain': 'Place dans un parking souterrain',
      'placeDansUnParkingSouterrainDImmeuble': 'Place dans un parking souterrain d\'immeuble résidentiel',
      'placeMoto': 'Motorcycle space',
      'placeVoiture': 'Place voiture',
      'placesLibres': 'Free spaces',
      'politiqueDeConfidentialite': 'Politique de confidentialité',
      'pourDesRaisonsDeSecuriteVeuillezNoter': 'Pour des raisons de sécurité, veuillez noter un mot\nde passe peut varier',
      'pourLesVisiteursEtLesDeplacements': 'Pour les visiteurs et les déplacements',
      'pourModifierLaPositionGpsUtilisezLa': 'Pour modifier la position GPS, utilisez la carte dans l\'application.',
      'prenezDesPhotosClairesMontrantLemplacementLacces': 'Prenez des photos claires montrant l’emplacement, l’accès et les environs.',
      'prenezDesPhotosEtTelechargezDesDocuments': 'Prenez des photos et téléchargez des documents légaux de municipalité',
      'prenom': 'First name',
      'prixJourDt': 'Price / day (TND)',
      'prixMoisDt': 'Price / month (TND)',
      'prixMoyJour': 'Avg. price / day',
      'prixParHeureOptionnel': 'Price per hour (optional)',
      'prixParJour': 'Price per day',
      'prixParMois': 'Price per month',
      'publier': 'Publish',
      'publiezSurTuniparkCestFacile': 'Publiez sur TuniPark ,\nc’est facile',
      'quelTypeDEmplacement': 'Quel type d\'emplacement ?',
      'quelTypeDEmplacementProposezVous': 'Quel type d\'emplacement\nproposez-vous ?',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 -etc.',
      'rechercher': 'Rechercher',
      'rechercherUneQuestion': 'Search a question...',
      'referral': 'Referral',
      'rentYourParkingSpaces': 'Rent your parking spaces.',
      'reservationLongueDuree': 'Réservation longue durée',
      'reservations': 'Reservations',
      'reservations2': 'Réservations',
      'resiliationDuPartenariat': 'Résiliation du partenariat',
      'resiliationPartenariat': 'Résiliation partenariat',
      'responsabilitesDuPartenaire': 'Responsabilités du partenaire',
      'retour': 'Retour',
      'retourALaccueil': 'Retour à l’accueil',
      'safetyInstructions': 'Safety instructions',
      'saisissezVotreAdresse': 'Enter your address',
      'saisissezVotreEMailOuNumeroDe': 'Saisissez votre e-mail ou numéro de téléphone\npour réinitialiser le mot de passe',
      'seConnecter': 'Se connecter',
      'securePrivateParking': 'Secure private\nparking',
      'securite': 'Security',
      'selectEnd': 'Select end',
      'selectStart': 'Select start',
      'selectionnezVotrePlaqueDimmatriculation': 'Selectionnez votre plaque d’immatriculation',
      'sessionExpired': 'Session Expired',
      'sessionsActives': 'Active sessions',
      'signOut': 'Sign out',
      'signalementDAbus': 'Signalement d\'abus',
      'signalerUnProbleme': 'Signaler un problème',
      'simpleCargoBiplaceEtc': 'Simple - Cargo - Biplace -etc.',
      'sousSolDImmeuble': 'Sous-sol d\'immeuble',
      'sousSolImmeubleEnnarjess': 'Sous-sol immeuble Ennarjess',
      'start': 'Start',
      'statut': 'Status',
      'suivant': 'Suivant',
      'supprimerLeCompte': 'Supprimer le compte',
      'telephone': 'Phone',
      'text': 'العربية',
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
      'text7cookiesettechnologiessimilaires': '7. Cookies et technologies similaires',
      'text7droitapplicable': '7. Droit applicable',
      'text8caracteresminimum': 'Minimum 8 characters',
      'text8modificationsdecettepolitique': '8. Modifications de cette politique',
      'text9contact': '9. Contact',
      'titreDeLAnnonce': 'Titre de l\'annonce',
      'total': 'Total',
      'unChiffre': 'One number',
      'unCodeDeVerificationSeraEnvoyePar': 'Un code de vérification sera envoyé par SMS pour confirmer.',
      'unLienDeConfirmationSeraEnvoyeA': 'Un lien de confirmation sera envoyé à votre nouvelle adresse.',
      'uneLettreMajuscule': 'One uppercase letter',
      'until': 'Until',
      'utilisateurs': 'Users',
      'vehiculesAcceptes': 'Accepted vehicles',
      'veloTrotinette': 'Vélo/trotinette',
      'verificationEnDeuxEtapes': 'Two-step verification',
      'verifierLeCode': 'Verify code',
      'verifiezVotreTelephone': 'Check your phone',
      'viewReceipt': 'View receipt',
      'viewSession': 'View session',
      'votreNouveauMotDePasseDoitContenir': 'Votre nouveau mot de passe doit contenir au moins 8 caractères.',
      'vousAvezUnCompte': 'Vous avez un compte ?',
      'vousNAvezAucunParking': 'Vous n\'avez aucun parking',
      'vousNAvezPasDeCompte': 'Vous n\'avez pas de compte ?',
      'vousNavezPasEncoreRecuLeCode': 'Vous n’avez pas encore reçu le code ?',
      'yourDedicatedSpace': 'Your\ndedicated\nspace',
      'yourSessionHasExpiredPleaseLogIn': 'Your session has expired. Please log in again.',
    },

    'ar': {
      'abonnementLongueDuree': 'Abonnement longue durée',
      'aboutUs': 'About us',
      'active': 'نشط',
      'addYourParkingPlace': 'Add Your Parking Place',
      'adresseEMail': 'البريد الإلكتروني',
      'adresseMail': 'البريد الإلكتروني',
      'aideSupport': 'المساعدة والدعم',
      'ajouterUnePlaqueDimmatriculation': 'Ajouter une plaque d’immatriculation',
      'ajoutezPhotosEtDocuments': 'Ajoutez photos et documents',
      'announce': 'إعلان',
      'appareilsConnectes': 'الأجهزة المتصلة',
      'authentificationBiometrique': 'المصادقة البيومترية',
      'autreChose': 'Autre chose ?',
      'availability': 'التوفر',
      'behavior': 'السلوك',
      'bookAgain': 'احجز مرة أخرى',
      'camionEtc': 'Camion -etc.',
      'caracteristiques': 'Caractéristiques',
      'carteBancaire': 'بطاقة بنكية',
      'centreDAide': 'Centre d\'aide',
      'changerLeMotDePasse': 'تغيير كلمة المرور',
      'chatEnDirect': 'الدردشة المباشرة',
      'chezTuniparkLaProtectionDeVosDonnees': 'Chez Tunipark, la protection de vos données personnelles est une priorité. Cette politique explique comment nous collectons, utilisons et protégeons vos informations lorsque vous utilisez notre application.',
      'commencer': 'ابدأ',
      'commissionTunipark': 'Commission Tunipark',
      'complet': 'ممتلئ',
      'comportementAttendu': 'Comportement attendu',
      'compte': 'الحساب',
      'conditionsDUtilisation': 'Conditions d\'utilisation',
      'conditionsPourDevenirPartenaire': 'Conditions pour devenir partenaire',
      'confirmer': 'Confirmer',
      'confirmerLeNouveauMotDePasse': 'Confirmer le nouveau mot de passe',
      'connexion': 'تسجيل الدخول',
      'contact': 'الاتصال',
      'continuer': 'متابعة',
      'creerUnNouveauMotDePasse': 'إنشاء كلمة مرور جديدة',
      'cryptogramme': 'رمز التحقق',
      'deconnecterTousLesAppareils': 'فصل جميع الأجهزة',
      'decrivezVotreEmplacement': 'Décrivez votre emplacement',
      'decrivezVotreProblemeIci': 'Décrivez votre problème ici...',
      'definissezVosTarifsAuJourOuAu': 'Définissez vos tarifs au jour ou au mois, puis publiez',
      'description': 'Description',
      'devenirPartenaire': 'كن شريكاً',
      'disponibilite': 'التوفر',
      'distance': 'المسافة',
      'duration': 'المدة',
      'duree': 'المدة:',
      'eMail': 'E-mail',
      'earnUpTo150DtPerYear': 'Earn up to 150 DT per year',
      'electricRecharge': 'Electric recharge',
      'emplacementEnPleinAirDansUneCour': 'Emplacement en plein air, dans une cour ou sur un terrain ouvert',
      'emplacementEnPleinAirOuCourOuverte': 'Emplacement en plein air ou cour ouverte',
      'emplacementProtegeParUneToitureOuUne': 'Emplacement protégé par une toiture ou une structure',
      'end': 'النهاية',
      'english': 'English',
      'enregistrer': 'Enregistrer',
      'enregistrerLeNouveauMotDePasse': 'حفظ كلمة المرور الجديدة',
      'enregistrerLesModifications': 'حفظ التعديلات',
      'envoyer': 'إرسال',
      'envoyerLeCode': 'إرسال الرمز',
      'envoyerLeLien': 'Envoyer le lien',
      'evaluerLApplication': 'Évaluer l\'application',
      'ex14RueDesJasminsElMenzah': 'Ex: 14 Rue des Jasmins, El Menzah 6',
      'expiration': 'تاريخ الانتهاء',
      'explore': 'استكشاف',
      'extend': 'تمديد',
      'faqCentreDAide': 'FAQ & Centre d\'aide',
      'fermeture': 'الإغلاق',
      'fermetureEx2200': 'وقت الغلق (مثال: 22:00)',
      'fixezVosPrixEtPubliez': 'Fixez vos prix et publiez',
      'flouci': 'Flouci',
      'fraisDeService': 'رسوم الخدمة',
      'francais': 'Français',
      'from': 'من',
      'garageDeMaison': 'Garage de maison',
      'garageIndividuelAttenantOuSepare': 'Garage individuel attenant ou séparé',
      'garageIndividuelAttenantOuSepareDUne': 'Garage individuel attenant ou séparé d\'une maison',
      'general': 'عام',
      'gererMesPlaces': 'إدارة أماكني',
      'golfPoloPeugeot308Etc': 'Golf - Polo - Peugeot 308 -etc.',
      'grand': 'كبير',
      'haut': 'مرتفع',
      'hauteur19M': 'Hauteur : 1.9 m',
      'helpYourLovedOnesParkInviteUp': 'Help your loved ones park! Invite up to 5 friends per year.',
      'heureJour': 'ساعة/يوم',
      'horairesDAcces': 'Horaires d\'accès',
      'identite': 'Identité',
      'indiquezLeTypeDeParkingSonAdresse': 'Indiquez le type de parking, son adresse et ses caractéristiques',
      'informationsDeLAnnonce': 'Informations de l\'annonce',
      'informationsPersonnelles': 'المعلومات الشخصية',
      'jour': 'اليوم',
      'laissezA0PourNePasProposer': 'Laissez à 0 pour ne pas proposer de tarif horaire',
      'langue': 'Langue',
      'largeur24M': 'Largeur : 2.4 m',
      'logIn': 'Log In',
      'long4mLarg175mHaut1': 'Long<4m, Larg<1.75m, Haut<1.5m',
      'longueur5M': 'Longueur : 5 m',
      'manageYourPlaces': 'Manage Your Places',
      'membreDepuis': 'عضو منذ',
      'mensualite': 'المعلوم الشهري',
      'mesPaiements': 'Mes paiements',
      'mesVehicules': 'Mes véhicules',
      'mettezAJourLAdresseSiNecessaire': 'Mettez à jour l\'adresse si nécessaire.',
      'miseAJourDisponible': 'تحديث متوفر',
      'mode': 'Mode',
      'modifierLEMail': 'Modifier l\'e-mail',
      'modifierLeNom': 'تعديل الاسم',
      'modifierLeTelephone': 'تعديل رقم الهاتف',
      'monProfil': 'ملفي الشخصي',
      'month': '/ شهر',
      'monthly': 'شهرياً',
      'motDePasse': 'كلمة المرور',
      'motDePasseActuel': 'Mot de passe actuel',
      'motDePasseOublie': 'Mot de passe oublié',
      'moto': 'دراجة نارية',
      'motoScooterEtc': 'Moto - Scooter -etc.',
      'moyen': 'متوسط',
      'myPersonalDetails': 'My personal details',
      'myVehicles': 'My vehicles',
      'navigate': 'الاتجاهات',
      'noCommitment': 'No\ncommitment',
      'noReservationsFound': 'No reservations found',
      'nom': 'اللقب',
      'nombreDePlaces': 'عدد الأماكن',
      'notification': 'الإشعارات',
      'notifications': 'Notifications',
      'nousAvonsEnvoyeUnLienDeReinitialisation': 'Nous avons envoyé un lien de réinitialisation à\n23*****3.\nSaisissez le code à 6 chiffres indiqué dans le\nmessage.',
      'nousContacter': 'اتصل بنا',
      'nouveauMotDePasse': 'Nouveau mot de passe',
      'nuit': 'الليل',
      'numeroDeCarte': 'Numéro de carte',
      'numeroDeTelephone': 'رقم الهاتف',
      'ouverture': 'الفتح',
      'ouvertureEx0700': 'وقت الفتح (مثال: 07:00)',
      'paid': 'مدفوع',
      'paiement': 'الدفع:',
      'paiement2': 'Paiement',
      'paiementConfirme': 'تم تأكيد الدفع',
      'parMois': 'شهرياً',
      'parametresDeLApp': 'Paramètres de l\'app',
      'parking': 'موقف',
      'parkingApprouve': 'تم قبول الموقف',
      'parkingCouvert': 'Parking couvert',
      'parkingExterieur': 'Parking extérieur',
      'partagerTunipark': 'Partager Tunipark',
      'partenaires': 'الشركاء',
      'past': 'السابق',
      'payment': 'Payment',
      'petit': 'صغير',
      'placeDansUnParkingSouterrain': 'Place dans un parking souterrain',
      'placeDansUnParkingSouterrainDImmeuble': 'Place dans un parking souterrain d\'immeuble résidentiel',
      'placeMoto': 'مكان دراجة نارية',
      'placeVoiture': 'Place voiture',
      'placesLibres': 'الأماكن الشاغرة',
      'politiqueDeConfidentialite': 'Politique de confidentialité',
      'pourDesRaisonsDeSecuriteVeuillezNoter': 'Pour des raisons de sécurité, veuillez noter un mot\nde passe peut varier',
      'pourLesVisiteursEtLesDeplacements': 'Pour les visiteurs et les déplacements',
      'pourModifierLaPositionGpsUtilisezLa': 'Pour modifier la position GPS, utilisez la carte dans l\'application.',
      'prenezDesPhotosClairesMontrantLemplacementLacces': 'Prenez des photos claires montrant l’emplacement, l’accès et les environs.',
      'prenezDesPhotosEtTelechargezDesDocuments': 'Prenez des photos et téléchargez des documents légaux de municipalité',
      'prenom': 'الاسم',
      'prixJourDt': 'السعر / اليوم (د.ت)',
      'prixMoisDt': 'السعر / الشهر (د.ت)',
      'prixMoyJour': 'متوسط السعر / اليوم',
      'prixParHeureOptionnel': 'السعر في الساعة (اختياري)',
      'prixParJour': 'السعر في اليوم',
      'prixParMois': 'السعر في الشهر',
      'publier': 'نشر',
      'publiezSurTuniparkCestFacile': 'Publiez sur TuniPark ,\nc’est facile',
      'quelTypeDEmplacement': 'Quel type d\'emplacement ?',
      'quelTypeDEmplacementProposezVous': 'Quel type d\'emplacement\nproposez-vous ?',
      'rangeRoverPeugeot3008Etc': 'Range Rover - Peugeot 3008 -etc.',
      'rechercher': 'Rechercher',
      'rechercherUneQuestion': 'ابحث عن سؤال...',
      'referral': 'Referral',
      'rentYourParkingSpaces': 'Rent your parking spaces.',
      'reservationLongueDuree': 'Réservation longue durée',
      'reservations': 'الحجوزات',
      'reservations2': 'Réservations',
      'resiliationDuPartenariat': 'Résiliation du partenariat',
      'resiliationPartenariat': 'Résiliation partenariat',
      'responsabilitesDuPartenaire': 'Responsabilités du partenaire',
      'retour': 'Retour',
      'retourALaccueil': 'Retour à l’accueil',
      'safetyInstructions': 'Safety instructions',
      'saisissezVotreAdresse': 'أدخل عنوانك',
      'saisissezVotreEMailOuNumeroDe': 'Saisissez votre e-mail ou numéro de téléphone\npour réinitialiser le mot de passe',
      'seConnecter': 'Se connecter',
      'securePrivateParking': 'Secure private\nparking',
      'securite': 'الأمان',
      'selectEnd': 'اختر النهاية',
      'selectStart': 'اختر البداية',
      'selectionnezVotrePlaqueDimmatriculation': 'Selectionnez votre plaque d’immatriculation',
      'sessionExpired': 'Session Expired',
      'sessionsActives': 'الجلسات النشطة',
      'signOut': 'Sign out',
      'signalementDAbus': 'Signalement d\'abus',
      'signalerUnProbleme': 'Signaler un problème',
      'simpleCargoBiplaceEtc': 'Simple - Cargo - Biplace -etc.',
      'sousSolDImmeuble': 'Sous-sol d\'immeuble',
      'sousSolImmeubleEnnarjess': 'Sous-sol immeuble Ennarjess',
      'start': 'البداية',
      'statut': 'الحالة',
      'suivant': 'Suivant',
      'supprimerLeCompte': 'Supprimer le compte',
      'telephone': 'الهاتف',
      'text': 'العربية',
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
      'text7cookiesettechnologiessimilaires': '7. Cookies et technologies similaires',
      'text7droitapplicable': '7. Droit applicable',
      'text8caracteresminimum': '8 أحرف على الأقل',
      'text8modificationsdecettepolitique': '8. Modifications de cette politique',
      'text9contact': '9. Contact',
      'titreDeLAnnonce': 'Titre de l\'annonce',
      'total': 'المجموع',
      'unChiffre': 'رقم واحد',
      'unCodeDeVerificationSeraEnvoyePar': 'Un code de vérification sera envoyé par SMS pour confirmer.',
      'unLienDeConfirmationSeraEnvoyeA': 'Un lien de confirmation sera envoyé à votre nouvelle adresse.',
      'uneLettreMajuscule': 'حرف كبير واحد',
      'until': 'إلى',
      'utilisateurs': 'المستخدمون',
      'vehiculesAcceptes': 'المركبات المقبولة',
      'veloTrotinette': 'Vélo/trotinette',
      'verificationEnDeuxEtapes': 'التحقق بخطوتين',
      'verifierLeCode': 'التحقق من الرمز',
      'verifiezVotreTelephone': 'تحقق من هاتفك',
      'viewReceipt': 'عرض الوصل',
      'viewSession': 'عرض الجلسة',
      'votreNouveauMotDePasseDoitContenir': 'Votre nouveau mot de passe doit contenir au moins 8 caractères.',
      'vousAvezUnCompte': 'Vous avez un compte ?',
      'vousNAvezAucunParking': 'Vous n\'avez aucun parking',
      'vousNAvezPasDeCompte': 'Vous n\'avez pas de compte ?',
      'vousNavezPasEncoreRecuLeCode': 'Vous n’avez pas encore reçu le code ?',
      'yourDedicatedSpace': 'Your\ndedicated\nspace',
      'yourSessionHasExpiredPleaseLogIn': 'Your session has expired. Please log in again.',
    },
  };

  static String get abonnementLongueDuree => _t('abonnementLongueDuree');
  static String get aboutUs => _t('aboutUs');
  static String get active => _t('active');
  static String get addYourParkingPlace => _t('addYourParkingPlace');
  static String get adresseEMail => _t('adresseEMail');
  static String get adresseMail => _t('adresseMail');
  static String get aideSupport => _t('aideSupport');
  static String get ajouterUnePlaqueDimmatriculation => _t('ajouterUnePlaqueDimmatriculation');
  static String get ajoutezPhotosEtDocuments => _t('ajoutezPhotosEtDocuments');
  static String get announce => _t('announce');
  static String get appareilsConnectes => _t('appareilsConnectes');
  static String get authentificationBiometrique => _t('authentificationBiometrique');
  static String get autreChose => _t('autreChose');
  static String get availability => _t('availability');
  static String get behavior => _t('behavior');
  static String get bookAgain => _t('bookAgain');
  static String get camionEtc => _t('camionEtc');
  static String get caracteristiques => _t('caracteristiques');
  static String get carteBancaire => _t('carteBancaire');
  static String get centreDAide => _t('centreDAide');
  static String get changerLeMotDePasse => _t('changerLeMotDePasse');
  static String get chatEnDirect => _t('chatEnDirect');
  static String get chezTuniparkLaProtectionDeVosDonnees => _t('chezTuniparkLaProtectionDeVosDonnees');
  static String get commencer => _t('commencer');
  static String get commissionTunipark => _t('commissionTunipark');
  static String get complet => _t('complet');
  static String get comportementAttendu => _t('comportementAttendu');
  static String get compte => _t('compte');
  static String get conditionsDUtilisation => _t('conditionsDUtilisation');
  static String get conditionsPourDevenirPartenaire => _t('conditionsPourDevenirPartenaire');
  static String get confirmer => _t('confirmer');
  static String get confirmerLeNouveauMotDePasse => _t('confirmerLeNouveauMotDePasse');
  static String get connexion => _t('connexion');
  static String get contact => _t('contact');
  static String get continuer => _t('continuer');
  static String get creerUnNouveauMotDePasse => _t('creerUnNouveauMotDePasse');
  static String get cryptogramme => _t('cryptogramme');
  static String get deconnecterTousLesAppareils => _t('deconnecterTousLesAppareils');
  static String get decrivezVotreEmplacement => _t('decrivezVotreEmplacement');
  static String get decrivezVotreProblemeIci => _t('decrivezVotreProblemeIci');
  static String get definissezVosTarifsAuJourOuAu => _t('definissezVosTarifsAuJourOuAu');
  static String get description => _t('description');
  static String get devenirPartenaire => _t('devenirPartenaire');
  static String get disponibilite => _t('disponibilite');
  static String get distance => _t('distance');
  static String get duration => _t('duration');
  static String get duree => _t('duree');
  static String get eMail => _t('eMail');
  static String get earnUpTo150DtPerYear => _t('earnUpTo150DtPerYear');
  static String get electricRecharge => _t('electricRecharge');
  static String get emplacementEnPleinAirDansUneCour => _t('emplacementEnPleinAirDansUneCour');
  static String get emplacementEnPleinAirOuCourOuverte => _t('emplacementEnPleinAirOuCourOuverte');
  static String get emplacementProtegeParUneToitureOuUne => _t('emplacementProtegeParUneToitureOuUne');
  static String get end => _t('end');
  static String get english => _t('english');
  static String get enregistrer => _t('enregistrer');
  static String get enregistrerLeNouveauMotDePasse => _t('enregistrerLeNouveauMotDePasse');
  static String get enregistrerLesModifications => _t('enregistrerLesModifications');
  static String get envoyer => _t('envoyer');
  static String get envoyerLeCode => _t('envoyerLeCode');
  static String get envoyerLeLien => _t('envoyerLeLien');
  static String get evaluerLApplication => _t('evaluerLApplication');
  static String get ex14RueDesJasminsElMenzah => _t('ex14RueDesJasminsElMenzah');
  static String get expiration => _t('expiration');
  static String get explore => _t('explore');
  static String get extend => _t('extend');
  static String get faqCentreDAide => _t('faqCentreDAide');
  static String get fermeture => _t('fermeture');
  static String get fermetureEx2200 => _t('fermetureEx2200');
  static String get fixezVosPrixEtPubliez => _t('fixezVosPrixEtPubliez');
  static String get flouci => _t('flouci');
  static String get fraisDeService => _t('fraisDeService');
  static String get francais => _t('francais');
  static String get from => _t('from');
  static String get garageDeMaison => _t('garageDeMaison');
  static String get garageIndividuelAttenantOuSepare => _t('garageIndividuelAttenantOuSepare');
  static String get garageIndividuelAttenantOuSepareDUne => _t('garageIndividuelAttenantOuSepareDUne');
  static String get general => _t('general');
  static String get gererMesPlaces => _t('gererMesPlaces');
  static String get golfPoloPeugeot308Etc => _t('golfPoloPeugeot308Etc');
  static String get grand => _t('grand');
  static String get haut => _t('haut');
  static String get hauteur19M => _t('hauteur19M');
  static String get helpYourLovedOnesParkInviteUp => _t('helpYourLovedOnesParkInviteUp');
  static String get heureJour => _t('heureJour');
  static String get horairesDAcces => _t('horairesDAcces');
  static String get identite => _t('identite');
  static String get indiquezLeTypeDeParkingSonAdresse => _t('indiquezLeTypeDeParkingSonAdresse');
  static String get informationsDeLAnnonce => _t('informationsDeLAnnonce');
  static String get informationsPersonnelles => _t('informationsPersonnelles');
  static String get jour => _t('jour');
  static String get laissezA0PourNePasProposer => _t('laissezA0PourNePasProposer');
  static String get langue => _t('langue');
  static String get largeur24M => _t('largeur24M');
  static String get logIn => _t('logIn');
  static String get long4mLarg175mHaut1 => _t('long4mLarg175mHaut1');
  static String get longueur5M => _t('longueur5M');
  static String get manageYourPlaces => _t('manageYourPlaces');
  static String get membreDepuis => _t('membreDepuis');
  static String get mensualite => _t('mensualite');
  static String get mesPaiements => _t('mesPaiements');
  static String get mesVehicules => _t('mesVehicules');
  static String get mettezAJourLAdresseSiNecessaire => _t('mettezAJourLAdresseSiNecessaire');
  static String get miseAJourDisponible => _t('miseAJourDisponible');
  static String get mode => _t('mode');
  static String get modifierLEMail => _t('modifierLEMail');
  static String get modifierLeNom => _t('modifierLeNom');
  static String get modifierLeTelephone => _t('modifierLeTelephone');
  static String get monProfil => _t('monProfil');
  static String get month => _t('month');
  static String get monthly => _t('monthly');
  static String get motDePasse => _t('motDePasse');
  static String get motDePasseActuel => _t('motDePasseActuel');
  static String get motDePasseOublie => _t('motDePasseOublie');
  static String get moto => _t('moto');
  static String get motoScooterEtc => _t('motoScooterEtc');
  static String get moyen => _t('moyen');
  static String get myPersonalDetails => _t('myPersonalDetails');
  static String get myVehicles => _t('myVehicles');
  static String get navigate => _t('navigate');
  static String get noCommitment => _t('noCommitment');
  static String get noReservationsFound => _t('noReservationsFound');
  static String get nom => _t('nom');
  static String get nombreDePlaces => _t('nombreDePlaces');
  static String get notification => _t('notification');
  static String get notifications => _t('notifications');
  static String get nousAvonsEnvoyeUnLienDeReinitialisation => _t('nousAvonsEnvoyeUnLienDeReinitialisation');
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
  static String get placeDansUnParkingSouterrain => _t('placeDansUnParkingSouterrain');
  static String get placeDansUnParkingSouterrainDImmeuble => _t('placeDansUnParkingSouterrainDImmeuble');
  static String get placeMoto => _t('placeMoto');
  static String get placeVoiture => _t('placeVoiture');
  static String get placesLibres => _t('placesLibres');
  static String get politiqueDeConfidentialite => _t('politiqueDeConfidentialite');
  static String get pourDesRaisonsDeSecuriteVeuillezNoter => _t('pourDesRaisonsDeSecuriteVeuillezNoter');
  static String get pourLesVisiteursEtLesDeplacements => _t('pourLesVisiteursEtLesDeplacements');
  static String get pourModifierLaPositionGpsUtilisezLa => _t('pourModifierLaPositionGpsUtilisezLa');
  static String get prenezDesPhotosClairesMontrantLemplacementLacces => _t('prenezDesPhotosClairesMontrantLemplacementLacces');
  static String get prenezDesPhotosEtTelechargezDesDocuments => _t('prenezDesPhotosEtTelechargezDesDocuments');
  static String get prenom => _t('prenom');
  static String get prixJourDt => _t('prixJourDt');
  static String get prixMoisDt => _t('prixMoisDt');
  static String get prixMoyJour => _t('prixMoyJour');
  static String get prixParHeureOptionnel => _t('prixParHeureOptionnel');
  static String get prixParJour => _t('prixParJour');
  static String get prixParMois => _t('prixParMois');
  static String get publier => _t('publier');
  static String get publiezSurTuniparkCestFacile => _t('publiezSurTuniparkCestFacile');
  static String get quelTypeDEmplacement => _t('quelTypeDEmplacement');
  static String get quelTypeDEmplacementProposezVous => _t('quelTypeDEmplacementProposezVous');
  static String get rangeRoverPeugeot3008Etc => _t('rangeRoverPeugeot3008Etc');
  static String get rechercher => _t('rechercher');
  static String get rechercherUneQuestion => _t('rechercherUneQuestion');
  static String get referral => _t('referral');
  static String get rentYourParkingSpaces => _t('rentYourParkingSpaces');
  static String get reservationLongueDuree => _t('reservationLongueDuree');
  static String get reservations => _t('reservations');
  static String get reservations2 => _t('reservations2');
  static String get resiliationDuPartenariat => _t('resiliationDuPartenariat');
  static String get resiliationPartenariat => _t('resiliationPartenariat');
  static String get responsabilitesDuPartenaire => _t('responsabilitesDuPartenaire');
  static String get retour => _t('retour');
  static String get retourALaccueil => _t('retourALaccueil');
  static String get safetyInstructions => _t('safetyInstructions');
  static String get saisissezVotreAdresse => _t('saisissezVotreAdresse');
  static String get saisissezVotreEMailOuNumeroDe => _t('saisissezVotreEMailOuNumeroDe');
  static String get seConnecter => _t('seConnecter');
  static String get securePrivateParking => _t('securePrivateParking');
  static String get securite => _t('securite');
  static String get selectEnd => _t('selectEnd');
  static String get selectStart => _t('selectStart');
  static String get selectionnezVotrePlaqueDimmatriculation => _t('selectionnezVotrePlaqueDimmatriculation');
  static String get sessionExpired => _t('sessionExpired');
  static String get sessionsActives => _t('sessionsActives');
  static String get signOut => _t('signOut');
  static String get signalementDAbus => _t('signalementDAbus');
  static String get signalerUnProbleme => _t('signalerUnProbleme');
  static String get simpleCargoBiplaceEtc => _t('simpleCargoBiplaceEtc');
  static String get sousSolDImmeuble => _t('sousSolDImmeuble');
  static String get sousSolImmeubleEnnarjess => _t('sousSolImmeubleEnnarjess');
  static String get start => _t('start');
  static String get statut => _t('statut');
  static String get suivant => _t('suivant');
  static String get supprimerLeCompte => _t('supprimerLeCompte');
  static String get telephone => _t('telephone');
  static String get text => _t('text');
  static String get text1acceptationdesconditions => _t('text1acceptationdesconditions');
  static String get text1collectedesdonnees => _t('text1collectedesdonnees');
  static String get text2descriptionduservice => _t('text2descriptionduservice');
  static String get text2utilisationdesdonnees => _t('text2utilisationdesdonnees');
  static String get text3creationdecompte => _t('text3creationdecompte');
  static String get text3partagedesdonnees => _t('text3partagedesdonnees');
  static String get text4proprieteintellectuelle => _t('text4proprieteintellectuelle');
  static String get text4securitedesdonnees => _t('text4securitedesdonnees');
  static String get text5conservationdesdonnees => _t('text5conservationdesdonnees');
  static String get text5limitationderesponsabilite => _t('text5limitationderesponsabilite');
  static String get text6modificationdesconditions => _t('text6modificationdesconditions');
  static String get text6vosdroits => _t('text6vosdroits');
  static String get text7cookiesettechnologiessimilaires => _t('text7cookiesettechnologiessimilaires');
  static String get text7droitapplicable => _t('text7droitapplicable');
  static String get text8caracteresminimum => _t('text8caracteresminimum');
  static String get text8modificationsdecettepolitique => _t('text8modificationsdecettepolitique');
  static String get text9contact => _t('text9contact');
  static String get titreDeLAnnonce => _t('titreDeLAnnonce');
  static String get total => _t('total');
  static String get unChiffre => _t('unChiffre');
  static String get unCodeDeVerificationSeraEnvoyePar => _t('unCodeDeVerificationSeraEnvoyePar');
  static String get unLienDeConfirmationSeraEnvoyeA => _t('unLienDeConfirmationSeraEnvoyeA');
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
  static String get votreNouveauMotDePasseDoitContenir => _t('votreNouveauMotDePasseDoitContenir');
  static String get vousAvezUnCompte => _t('vousAvezUnCompte');
  static String get vousNAvezAucunParking => _t('vousNAvezAucunParking');
  static String get vousNAvezPasDeCompte => _t('vousNAvezPasDeCompte');
  static String get vousNavezPasEncoreRecuLeCode => _t('vousNavezPasEncoreRecuLeCode');
  static String get yourDedicatedSpace => _t('yourDedicatedSpace');
  static String get yourSessionHasExpiredPleaseLogIn => _t('yourSessionHasExpiredPleaseLogIn');
}
