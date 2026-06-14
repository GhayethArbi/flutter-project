import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_intro_step_item.dart';
import '../widgets/announcement_primary_button.dart';

class AnnouncementIntroScreen extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onStart;

  const AnnouncementIntroScreen({super.key, this.onClose, this.onStart});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: rs.adaptive(
                    mobile: rs.w,
                    tablet: 700,
                    desktop: 850,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rs.adaptive(
                      mobile: 16,
                      tablet: 24,
                      desktop: 32,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: rs.adaptive(
                          mobile: 10,
                          tablet: 16,
                          desktop: 20,
                        ),
                      ),

                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(
                            rs.adaptive(mobile: 18, tablet: 24, desktop: 28),
                            rs.adaptive(mobile: 28, tablet: 32, desktop: 36),
                            rs.adaptive(mobile: 18, tablet: 24, desktop: 28),
                            rs.adaptive(mobile: 20, tablet: 24, desktop: 28),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(
                              rs.adaptive(mobile: 14, tablet: 18, desktop: 20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Publiez sur TuniPark ,\nc’est facile',
                                  style: TextStyle(
                                    fontSize: rs.adaptive(
                                      mobile: 22,
                                      tablet: 26,
                                      desktop: 30,
                                    ),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1F1F1F),
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(
                                  height: rs.adaptive(
                                    mobile: 34,
                                    tablet: 40,
                                    desktop: 46,
                                  ),
                                ),
                                const AnnouncementIntroStepItem(
                                  number: '1',
                                  title: 'Décrivez votre emplacement',
                                  subtitle:
                                      'Indiquez le type de parking, son adresse et ses caractéristiques',
                                ),
                                const AnnouncementIntroStepItem(
                                  number: '2',
                                  title: 'Ajoutez photos et documents',
                                  subtitle:
                                      'Prenez des photos et téléchargez des documents légaux de municipalité',
                                ),
                                const AnnouncementIntroStepItem(
                                  number: '3',
                                  title: 'Fixez vos prix et publiez',
                                  subtitle:
                                      'Définissez vos tarifs au jour ou au mois, puis publiez',
                                  showDivider: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnnouncementFixedBottomActions(
                        child: SizedBox(
                          width: double.infinity,
                          child: AnnouncementPrimaryButton(
                            text: 'Commencer',
                            onPressed: onStart ??
                                () {
                                  context
                                      .read<AnnouncementFlowCubit>()
                                      .goToStep(1);
                                },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}