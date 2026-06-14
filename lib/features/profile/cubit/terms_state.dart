part of 'terms_cubit.dart';

enum TermsTab { general, users, partners }

class TermsState extends Equatable {
  const TermsState({
    this.activeTab = TermsTab.general,
    this.expandedIndex,
  });

  final TermsTab activeTab;
  final int? expandedIndex;

  List<TermsSection> get currentSections {
    switch (activeTab) {
      case TermsTab.general:
        return TermsSection.general;
      case TermsTab.users:
        return TermsSection.users;
      case TermsTab.partners:
        return TermsSection.partners;
    }
  }

  TermsState copyWith({
    TermsTab? activeTab,
    int? expandedIndex,
    bool clearExpanded = false,
  }) {
    return TermsState(
      activeTab: activeTab ?? this.activeTab,
      expandedIndex: clearExpanded ? null : (expandedIndex ?? this.expandedIndex),
    );
  }

  @override
  List<Object?> get props => [activeTab, expandedIndex];
}

class TermsSection {
  const TermsSection({required this.title, required this.content});

  final String title;
  final String content;

  static const List<TermsSection> general = [
    TermsSection(
      title: '1. Acceptation des conditions',
      content:
          'En téléchargeant et en utilisant l\'application Tunipark, vous acceptez sans réserve les présentes conditions générales d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.',
    ),
    TermsSection(
      title: '2. Description du service',
      content:
          'Tunipark est une plateforme de mise en relation entre conducteurs recherchant des places de parking et propriétaires de places disponibles en Tunisie. Tunipark agit en tant qu\'intermédiaire et n\'est pas responsable des parkings eux-mêmes.',
    ),
    TermsSection(
      title: '3. Création de compte',
      content:
          'L\'utilisation du service requiert la création d\'un compte avec des informations exactes et complètes. Vous êtes responsable de la confidentialité de vos identifiants et de toute activité effectuée depuis votre compte.',
    ),
    TermsSection(
      title: '4. Propriété intellectuelle',
      content:
          'L\'application Tunipark, son contenu, son logo et toutes ses fonctionnalités sont la propriété exclusive de Tunipark SAS et sont protégés par les lois tunisiennes sur la propriété intellectuelle.',
    ),
    TermsSection(
      title: '5. Limitation de responsabilité',
      content:
          'Tunipark ne saurait être tenu responsable des dommages directs ou indirects résultant de l\'utilisation du service, notamment en cas d\'indisponibilité d\'une place réservée, de dommages sur votre véhicule, ou d\'interruption du service.',
    ),
    TermsSection(
      title: '6. Modification des conditions',
      content:
          'Tunipark se réserve le droit de modifier ces conditions à tout moment. Les utilisateurs seront informés des modifications importantes via notification dans l\'application au moins 14 jours avant leur entrée en vigueur.',
    ),
    TermsSection(
      title: '7. Droit applicable',
      content:
          'Les présentes conditions sont soumises au droit tunisien. Tout litige sera soumis à la compétence exclusive des tribunaux de Tunis, sauf dispositions légales contraires.',
    ),
  ];

  static const List<TermsSection> users = [
    TermsSection(
      title: 'Réservations',
      content:
          'Les réservations sont confirmées après paiement. L\'annulation gratuite est possible jusqu\'à 30 minutes avant l\'heure prévue. Au-delà, des frais d\'annulation peuvent s\'appliquer selon la politique du parking.',
    ),
    TermsSection(
      title: 'Paiement',
      content:
          'Les paiements sont effectués via les moyens acceptés dans l\'application. Tunipark utilise des prestataires de paiement sécurisés et ne stocke pas vos données bancaires sur ses serveurs.',
    ),
    TermsSection(
      title: 'Comportement attendu',
      content:
          'Les utilisateurs s\'engagent à :\n• Respecter les règles des parkings partenaires\n• Occuper uniquement la place réservée\n• Libérer la place à l\'heure prévue\n• Signaler tout incident dans l\'application',
    ),
    TermsSection(
      title: 'Signalement d\'abus',
      content:
          'Tout comportement abusif, frauduleux ou contraire aux présentes conditions peut entraîner la suspension temporaire ou définitive du compte concerné.',
    ),
  ];

  static const List<TermsSection> partners = [
    TermsSection(
      title: 'Conditions pour devenir partenaire',
      content:
          'Pour proposer votre place sur Tunipark, vous devez être le propriétaire légal ou disposer d\'une autorisation écrite pour sous-louer. La place doit être accessible, sécurisée et conforme aux normes locales.',
    ),
    TermsSection(
      title: 'Commission Tunipark',
      content:
          'Tunipark prélève une commission de 15 % sur chaque transaction réalisée via la plateforme. Les versements sont effectués sur votre compte bancaire chaque mois.',
    ),
    TermsSection(
      title: 'Responsabilités du partenaire',
      content:
          'Le partenaire s\'engage à :\n• Maintenir la place disponible aux horaires indiqués\n• Assurer la propreté et la sécurité de la place\n• Signaler toute indisponibilité à l\'avance\n• Ne pas discriminer les utilisateurs',
    ),
    TermsSection(
      title: 'Résiliation du partenariat',
      content:
          'Le partenariat peut être résilié par l\'une ou l\'autre partie avec un préavis de 30 jours. Tunipark se réserve le droit de suspendre immédiatement un partenaire en cas de manquement grave.',
    ),
  ];
}