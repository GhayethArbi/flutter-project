import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const List<_PolicySection> _sections = [
    _PolicySection(
      title: '1. Collecte des données',
      content:
          'Tunipark collecte uniquement les informations nécessaires au bon fonctionnement du service : nom, prénom, adresse e-mail, numéro de téléphone, données de localisation (uniquement lors de l\'utilisation active de l\'application), et informations relatives à vos véhicules enregistrés.',
    ),
    _PolicySection(
      title: '2. Utilisation des données',
      content:
          'Vos données sont utilisées exclusivement pour :\n• Gérer votre compte et vos réservations\n• Vous fournir les services Tunipark\n• Améliorer notre application et personnaliser votre expérience\n• Vous envoyer des notifications liées à vos réservations\n• Respecter nos obligations légales en Tunisie',
    ),
    _PolicySection(
      title: '3. Partage des données',
      content:
          'Tunipark ne vend jamais vos données personnelles à des tiers. Vos informations peuvent être partagées avec nos partenaires de parking uniquement dans le cadre de votre réservation, et avec les prestataires de paiement pour traiter vos transactions de manière sécurisée.',
    ),
    _PolicySection(
      title: '4. Sécurité des données',
      content:
          'Nous mettons en œuvre des mesures techniques et organisationnelles pour protéger vos données contre tout accès non autorisé, perte ou divulgation. Toutes les transmissions sont chiffrées via HTTPS et les données sensibles sont stockées de manière sécurisée.',
    ),
    _PolicySection(
      title: '5. Conservation des données',
      content:
          'Vos données personnelles sont conservées pendant toute la durée de votre compte actif et supprimées dans un délai de 30 jours suivant la fermeture de votre compte, sauf obligation légale de conservation plus longue.',
    ),
    _PolicySection(
      title: '6. Vos droits',
      content:
          'Conformément à la législation tunisienne sur la protection des données, vous disposez des droits suivants :\n• Droit d\'accès à vos données\n• Droit de rectification\n• Droit à l\'effacement (droit à l\'oubli)\n• Droit de limitation du traitement\n• Droit à la portabilité\n\nPour exercer ces droits, contactez-nous à : privacy@tunipark.tn',
    ),
    _PolicySection(
      title: '7. Cookies et technologies similaires',
      content:
          'L\'application utilise des cookies fonctionnels indispensables au fonctionnement du service (authentification, préférences). Aucun cookie publicitaire ou de suivi tiers n\'est utilisé sans votre consentement explicite.',
    ),
    _PolicySection(
      title: '8. Modifications de cette politique',
      content:
          'Tunipark se réserve le droit de modifier cette politique de confidentialité. En cas de changements significatifs, vous serez notifié par e-mail ou via une notification dans l\'application au moins 14 jours avant l\'entrée en vigueur des modifications.',
    ),
    _PolicySection(
      title: '9. Contact',
      content:
          'Pour toute question concernant cette politique ou le traitement de vos données personnelles, contactez notre délégué à la protection des données :\n\nE-mail : privacy@tunipark.tn\nAdresse : Tunipark SAS, Tunis, Tunisie',
    ),
  ];

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
              padding: const EdgeInsets.fromLTRB(8, 8, 22, 20),
              child: Row(
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
                  Expanded(
                    child: Text(
                      AppStrings.politiqueDeConfidentialite,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
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
                    // Last updated chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
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
                            size: 14,
                            color: Color(0xFF3B6D11),
                          ),
                          SizedBox(width: 6),
                          Text(
                            AppStrings.derniereMiseAJour1erJanvier,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF3B6D11),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Intro
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFE8E8E8),
                          width: 0.5,
                        ),
                      ),
                      child: const Text(
                        'Chez Tunipark, la protection de vos données personnelles est une priorité. Cette politique explique comment nous collectons, utilisons et protégeons vos informations lorsque vous utilisez notre application.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sections
                    ..._sections.map((s) => _PolicySectionCard(section: s)),

                    // Contact button
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.email_outlined,
                          size: 18,
                          color: Color(0xFF3B6D11),
                        ),
                        label: Text(
                          AppStrings.nousContacterPourVosDroits,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3B6D11),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFB7F000),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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

class _PolicySectionCard extends StatefulWidget {
  final _PolicySection section;
  const _PolicySectionCard({required this.section});

  @override
  State<_PolicySectionCard> createState() => _PolicySectionCardState();
}

class _PolicySectionCardState extends State<_PolicySectionCard> {
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

class _PolicySection {
  final String title;
  final String content;
  const _PolicySection({required this.title, required this.content});
}
