part of 'help_center_cubit.dart';

class HelpCenterState extends Equatable {
  const HelpCenterState({
    this.searchQuery = '',
    this.expandedIndex,
  });

  final String searchQuery;
  final int? expandedIndex;

  bool get hasSearch => searchQuery.isNotEmpty;

  List<FaqItem> get filteredFaqs {
    if (searchQuery.isEmpty) return FaqItem.all;
    final q = searchQuery.toLowerCase();
    return FaqItem.all
        .where((f) =>
            f.question.toLowerCase().contains(q) ||
            f.answer.toLowerCase().contains(q))
        .toList();
  }

  HelpCenterState copyWith({
    String? searchQuery,
    int? expandedIndex,
    bool clearExpanded = false,
  }) {
    return HelpCenterState(
      searchQuery: searchQuery ?? this.searchQuery,
      expandedIndex: clearExpanded ? null : (expandedIndex ?? this.expandedIndex),
    );
  }

  @override
  List<Object?> get props => [searchQuery, expandedIndex];
}

class FaqItem {
  const FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  static const List<FaqItem> all = [
    FaqItem(
      question: 'Comment réserver une place de parking ?',
      answer:
          'Ouvrez l\'application, recherchez une place disponible près de votre destination, sélectionnez-la et confirmez votre réservation. Vous recevrez une confirmation par notification.',
    ),
    FaqItem(
      question: 'Comment annuler une réservation ?',
      answer:
          'Rendez-vous dans "Mes réservations", sélectionnez la réservation à annuler et appuyez sur "Annuler". L\'annulation est gratuite jusqu\'à 30 minutes avant l\'heure prévue.',
    ),
    FaqItem(
      question: 'Comment ajouter un moyen de paiement ?',
      answer:
          'Allez dans Profil → Mes paiements → Ajouter une carte. Nous acceptons les cartes Visa, Mastercard et le paiement en espèces dans certains parkings partenaires.',
    ),
    FaqItem(
      question: 'Comment enregistrer mon véhicule ?',
      answer:
          'Dans Profil → Mes véhicules, appuyez sur "+" et saisissez les informations de votre véhicule (marque, modèle, immatriculation). Vous pouvez enregistrer jusqu\'à 3 véhicules.',
    ),
    FaqItem(
      question: 'Que faire si ma place réservée est occupée ?',
      answer:
          'Si votre place est occupée à votre arrivée, contactez notre support via le chat. Nous trouverons une solution rapidement et vous ne serez pas facturé.',
    ),
    FaqItem(
      question: 'Comment devenir partenaire Tunipark ?',
      answer:
          'Si vous possédez des places de parking, vous pouvez les mettre à disposition et générer des revenus. Rendez-vous dans Profil → Devenir partenaire pour soumettre votre demande.',
    ),
    FaqItem(
      question: 'Comment modifier mes informations personnelles ?',
      answer:
          'Allez dans Profil → Informations personnelles. Vous pouvez modifier votre nom, numéro de téléphone et adresse e-mail. Un code de vérification sera envoyé pour confirmer tout changement.',
    ),
  ];
}