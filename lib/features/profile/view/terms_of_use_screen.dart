import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  int _selectedTab = 0; // 0 = Conditions, 1 = Utilisateurs, 2 = Partenaires

  static const List<_TermSection> _generalSections = [
    _TermSection(
      title: '1. Acceptation des conditions',
      content:
          'En téléchargeant et en utilisant l\'application Tunipark, vous acceptez sans réserve les présentes conditions générales d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.',
    ),
    _TermSection(
      title: '2. Description du service',
      content:
          'Tunipark est une plateforme de mise en relation entre conducteurs recherchant des places de parking et propriétaires de places disponibles en Tunisie. Tunipark agit en tant qu\'intermédiaire et n\'est pas responsable des parkings eux-mêmes.',
    ),
    _TermSection(
      title: '3. Création de compte',
      content:
          'L\'utilisation du service requiert la création d\'un compte avec des informations exactes et complètes. Vous êtes responsable de la confidentialité de vos identifiants et de toute activité effectuée depuis votre compte.',
    ),
    _TermSection(
      title: '4. Propriété intellectuelle',
      content:
          'L\'application Tunipark, son contenu, son logo et toutes ses fonctionnalités sont la propriété exclusive de Tunipark SAS et sont protégés par les lois tunisiennes sur la propriété intellectuelle. Toute reproduction sans autorisation est interdite.',
    ),
    _TermSection(
      title: '5. Limitation de responsabilité',
      content:
          'Tunipark ne saurait être tenu responsable des dommages directs ou indirects résultant de l\'utilisation du service, notamment en cas d\'indisponibilité d\'une place réservée, de dommages sur votre véhicule, ou d\'interruption du service.',
    ),
    _TermSection(
      title: '6. Modification des conditions',
      content:
          'Tunipark se réserve le droit de modifier ces conditions à tout moment. Les utilisateurs seront informés des modifications importantes via notification dans l\'application ou par e-mail, au moins 14 jours avant leur entrée en vigueur.',
    ),
    _TermSection(
      title: '7. Droit applicable',
      content:
          'Les présentes conditions sont soumises au droit tunisien. Tout litige sera soumis à la compétence exclusive des tribunaux de Tunis, sauf dispositions légales contraires.',
    ),
  ];

  static const List<_TermSection> _userSections = [
    _TermSection(
      title: 'Réservations',
      content:
          'Les réservations sont confirmées après paiement. L\'annulation gratuite est possible jusqu\'à 30 minutes avant l\'heure prévue. Au-delà, des frais d\'annulation peuvent s\'appliquer selon la politique du parking.',
    ),
    _TermSection(
      title: 'Paiement',
      content:
          'Les paiements sont effectués via les moyens acceptés dans l\'application. Tunipark utilise des prestataires de paiement sécurisés et ne stocke pas vos données bancaires sur ses serveurs.',
    ),
    _TermSection(
      title: 'Comportement attendu',
      content:
          'Les utilisateurs s\'engagent à :\n• Respecter les règles des parkings partenaires\n• Occuper uniquement la place réservée\n• Libérer la place à l\'heure prévue\n• Signaler tout incident dans l\'application',
    ),
    _TermSection(
      title: 'Signalement d\'abus',
      content:
          'Tout comportement abusif, frauduleux ou contraire aux présentes conditions peut entraîner la suspension temporaire ou définitive du compte concerné.',
    ),
  ];

  static const List<_TermSection> _partnerSections = [
    _TermSection(
      title: 'Conditions pour devenir partenaire',
      content:
          'Pour proposer votre place sur Tunipark, vous devez être le propriétaire légal ou disposer d\'une autorisation écrite pour sous-louer. La place doit être accessible, sécurisée et conforme aux normes locales.',
    ),
    _TermSection(
      title: 'Commission Tunipark',
      content:
          'Tunipark prélève une commission de 15% sur chaque transaction réalisée via la plateforme. Les versements sont effectués sur votre compte bancaire chaque mois, pour les réservations du mois précédent.',
    ),
    _TermSection(
      title: 'Responsabilités du partenaire',
      content:
          'Le partenaire s\'engage à :\n• Maintenir la place disponible aux horaires indiqués\n• Assurer la propreté et la sécurité de la place\n• Signaler toute indisponibilité à l\'avance\n• Ne pas discriminer les utilisateurs',
    ),
    _TermSection(
      title: 'Résiliation partenariat',
      content:
          'Le partenariat peut être résilié par l\'une ou l\'autre partie avec un préavis de 30 jours. Tunipark se réserve le droit de suspendre immédiatement un partenaire en cas de manquement grave à ses obligations.',
    ),
  ];

  List<_TermSection> get _currentSections {
    switch (_selectedTab) {
      case 0:
        return _generalSections;
      case 1:
        return _userSections;
      case 2:
        return _partnerSections;
      default:
        return _generalSections;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFB7F000),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 22, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppStrings.conditionsDUtilisation,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Tabs
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        _TabChip(
                          label: 'Général',
                          selected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                        const SizedBox(width: 8),
                        _TabChip(
                          label: 'Utilisateurs',
                          selected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                        const SizedBox(width: 8),
                        _TabChip(
                          label: 'Partenaires',
                          selected: _selectedTab == 2,
                          onTap: () => setState(() => _selectedTab = 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Last updated
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF3CF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFB7F000),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.update,
                                size: 13,
                                color: Color(0xFF3B6D11),
                              ),
                              SizedBox(width: 5),
                              Text(
                                AppStrings.version101erJanvier2025,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF3B6D11),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Sections
                    ..._currentSections.map(
                      (s) => _TermSectionCard(section: s),
                    ),

                    const SizedBox(height: 12),

                    // Accept note
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5FFD6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFB7F000),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: Color(0xFF3B6D11),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              AppStrings.enUtilisantTuniparkVousConfirmezAvoir,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF3B6D11),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermSectionCard extends StatefulWidget {
  final _TermSection section;
  const _TermSectionCard({required this.section});

  @override
  State<_TermSectionCard> createState() => _TermSectionCardState();
}

class _TermSectionCardState extends State<_TermSectionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 0.5),
      ),
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.section.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _expanded
                            ? const Color(0xFF3B6D11)
                            : Colors.black87,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: _expanded
                          ? const Color(0xFF3B6D11)
                          : Colors.black26,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.section.content,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                ),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? const Color(0xFFB7F000) : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class _TermSection {
  final String title;
  final String content;
  const _TermSection({required this.title, required this.content});
}
