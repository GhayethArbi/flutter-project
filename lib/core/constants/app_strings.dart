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
    },

    'ar': {
      'adresse': 'العنوان',
      'adresseDuParking': 'عنوان موقف السيارات',
      'aiSummary': 'ملخص الذكاء الاصطناعي',
      'ajouter': 'إضافة',
      'ajouterUnVehicule': 'إضافة مركبة',
      'ajouterUneCarteBancaire': 'إضافة بطاقة بنكية',
      'ajouterUnePlaqueDimmatriculation': 'إضافة لوحة ترقيم',
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
      'caracteristiques': 'الخصائص',
      'cetteActionEstIrreversibleVoulezVous':
          'هذا الإجراء لا يمكن التراجع عنه. هل تريد حقاً حذف حسابك؟',
      'chezTuniparkLaProtectionDeVos':
          'في Tunipark، حماية بياناتك الشخصية أولوية.',
      'commencezASaisirUneAdresse': 'ابدأ بكتابة العنوان',
      'compatibleAvec': 'متوافق مع',
      'conditionsDUtilisation': 'شروط الاستخدام',
      'confirmer': 'تأكيد',
      'connectezVousPourAccederAVotre': 'سجّل الدخول للوصول إلى حسابك.',
      'creerUnCompte': 'إنشاء حساب',
      'decrivezVotreEmplacement': 'صف مكان الوقوف الخاص بك',
      'definissezVosPrixVousPourrezLes':
          'حدد الأسعار. يمكنك تعديلها في أي وقت.',
      'derniereMiseAJour1erJanvier': 'آخر تحديث: 1 جانفي 2025',
      'description': 'الوصف',
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
      'francais': 'الفرنسية',
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
      'langue': 'اللغة',
      'locationPermissionDenied': 'تم رفض إذن الموقع.',
      'locationPermissionPermanentlyDeniedOpenApp':
          'تم رفض إذن الموقع نهائياً. افتح إعدادات التطبيق.',
      'mesAnnonces': 'إعلاناتي',
      'mesPaiements': 'مدفوعاتي',
      'mesReservations': 'حجوزاتي',
      'mesVehicules': 'مركباتي',
      'mettezAJourL': 'قم بتحديث',
      'mode': 'الوضع',
      'modifier': 'تعديل',
      'motDePasseModifieAvecSucces': 'تم تغيير كلمة المرور بنجاح',
      'motDePasseOublie': 'نسيت كلمة المرور؟',
      'motDePasseReinitialise': 'تمت إعادة تعيين كلمة المرور!',
      'no': 'لا',
      'noReservationsFound': 'لا توجد حجوزات',
      'notifications': 'الإشعارات',
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
      'placeVoiture': 'مكان سيارة',
      'placesDisponibles': 'الأماكن المتاحة',
      'politiqueDeConfidentialite': 'سياسة الخصوصية',
      'pourModifierLaPositionGpsUtilisez': 'لتغيير موقع GPS، استخدم الخريطة في',
      'pourToutVehicule': 'لكل المركبات',
      'prenezDesPhotosClairesMontrantLemplacement':
          'التقط صوراً واضحة تُظهر المكان والمدخل والمحيط.',
      'publicationEnCours': 'جاري النشر…',
      'publierMonPremierParking': 'نشر أول موقف لي',
      'publiezSurTuniparkCestFacile': 'النشر على TuniPark\nسهل',
      'quelTypeD': 'ما نوع',
      'rechercher': 'بحث',
      'reessayer': 'إعادة المحاولة',
      'renvoyerLeCode': 'إعادة إرسال الرمز',
      'reservation100Digitale': 'حجز رقمي 100%',
      'retour': 'رجوع',
      'retourALaccueil': 'العودة إلى الرئيسية',
      'seConnecter': 'تسجيل الدخول',
      'seConnecter2': 'تسجيل الدخول',
      'seDeconnecter': 'تسجيل الخروج',
      'selectionnezAuMoinsUnTypeDe': 'اختر نوع مركبة واحداً على الأقل',
      'selectionnezVotrePlaqueDimmatriculation': 'اختر لوحة ترقيم مركبتك',
      'signalerUnProbleme': 'الإبلاغ عن مشكلة',
      'stationnerIci': 'اركن هنا',
      'suivant': 'التالي',
      'supprimer': 'حذف',
      'supprimerLeCompte': 'حذف الحساب',
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
}
