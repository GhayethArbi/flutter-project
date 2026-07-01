import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AnnouncementStepFiveScreen extends StatelessWidget {
  const AnnouncementStepFiveScreen({super.key});

  Future<void> _pickDocuments(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null) return;

    final files = result.paths
        .whereType<String>()
        .map((path) => File(path))
        .toList();

    if (!context.mounted) return;

    context.read<AnnouncementFlowCubit>().addLegalDocuments(files);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        final cubit = context.read<AnnouncementFlowCubit>();

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
                child: Column(
                  children: [
                    /// CONTENT
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(
                            mobile: 16,
                            tablet: 24,
                            desktop: 32,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: rs.adaptive(mobile: 8, tablet: 12, desktop: 16)),

                            AnnouncementFlowHeader(
                              step: 6,
                              totalSteps: 7,
                              onBack: () => cubit.goToStep(5),
                              onClose: () => Navigator.pop(context),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),

                            Text(AppStrings.documentsLegaux,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 20,
                                  tablet: 22,
                                  desktop: 24,
                                ),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF222222),
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),

                            Text(AppStrings.telechargezLesDocumentsLegalisesDeLa,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 17,
                                ),
                                height: 1.45,
                                color: const Color(0xFF666666),
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 30, tablet: 36, desktop: 42)),

                            /// DOCUMENT BOX
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(
                                rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCFA7),
                                borderRadius: BorderRadius.circular(
                                  rs.adaptive(mobile: 8, tablet: 10, desktop: 12),
                                ),
                              ),
                              child: Text(AppStrings.autorisationDeLaMunicipalite,
                                style: TextStyle(
                                  fontSize: rs.adaptive(
                                    mobile: 12,
                                    tablet: 13,
                                    desktop: 14,
                                  ),
                                  height: 1.45,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF5A5A5A),
                                ),
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 36)),

                            /// PICK BUTTON
                            GestureDetector(
                              onTap: () => _pickDocuments(context),
                              child: Container(
                                width: double.infinity,
                                height: rs.adaptive(
                                  mobile: 124,
                                  tablet: 130,
                                  desktop: 140,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: rs.adaptive(
                                    mobile: 0,
                                    tablet: 40,
                                    desktop: 60,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFBDBDBD),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.file_download_outlined,
                                      size: rs.adaptive(
                                        mobile: 24,
                                        tablet: 26,
                                        desktop: 28,
                                      ),
                                      color: const Color(0xFF555555),
                                    ),
                                    SizedBox(height: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
                                    Text(AppStrings.telechargezUnDocument,
                                      style: TextStyle(
                                        fontSize: rs.adaptive(
                                          mobile: 13,
                                          tablet: 14,
                                          desktop: 15,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 16, tablet: 18, desktop: 20)),

                            /// FILE LIST
                            ...state.legalDocuments.map(
                              (file) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.insert_drive_file),
                                title: Text(
                                  file.path.split('/').last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () =>
                                      cubit.removeLegalDocument(file),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// BOTTOM BUTTONS
                    AnnouncementFixedBottomActions(
                      child: Row(
                        children: [
                          Expanded(
                            child: _BottomButton(
                              text: AppStrings.retour,
                              isPrimary: false,
                              onPressed: () => cubit.goToStep(4),
                            ),
                          ),
                          SizedBox(width: rs.adaptive(mobile: 14, tablet: 18, desktop: 20)),
                          Expanded(
                            child: _BottomButton(
                              text: AppStrings.suivant,
                              isPrimary: true,
                              onPressed: state.legalDocuments.isEmpty
                                  ? null
                                  : () => cubit.goToStep(7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BottomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _BottomButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFFB7F000) : Colors.white,
          disabledBackgroundColor:
              isPrimary ? const Color(0xFFB7F000).withOpacity(0.4) : Colors.white,
          side: const BorderSide(color: Color(0xFFB7F000)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF222222),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}