import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';

class AnnouncementStepFourScreen extends StatelessWidget {
  const AnnouncementStepFourScreen({super.key});

  Future<void> _pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(imageQuality: 80);

    if (pickedFiles.isEmpty) return;

    final files = pickedFiles.map((xFile) => File(xFile.path)).toList();

    if (!context.mounted) return;
    context.read<AnnouncementFlowCubit>().addPhotos(files);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        final cubit = context.read<AnnouncementFlowCubit>();

        final boxSize = rs.adaptive(
          mobile: 104,
          tablet: 110,
          desktop: 120,
        );

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
                              step: 5,
                              totalSteps: 7,
                              onBack: () => cubit.goToStep(4),
                              onClose: () => Navigator.pop(context),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),

                            Text(
                              'Ajoutez des photos',
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

                            Text(
                              'Ajoutez au moins 3 photos pour mettre en\nvaleur votre emplacement',
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 17,
                                ),
                                height: 1.5,
                                color: const Color(0xFF666666),
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 30, tablet: 36, desktop: 42)),

                            /// GRID
                            Wrap(
                              spacing: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
                              runSpacing: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
                              children: [
                                _AddPhotoBox(
                                  size: boxSize,
                                  onTap: () => _pickImages(context),
                                ),
                                ...state.photos.map(
                                  (photo) => _PhotoPreview(
                                    size: boxSize,
                                    file: photo,
                                    onRemove: () => cubit.removePhoto(photo),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),

                            /// INFO BOX
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(
                                rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFFFBE),
                                borderRadius: BorderRadius.circular(
                                  rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                                ),
                                border: Border.all(
                                  color: const Color(0xFFD6EA74),
                                ),
                              ),
                              child: Text(
                                'Prenez des photos claires montrant l’emplacement, l’accès et les environs. '
                                'Des photos de qualité augmentent vos chance de location de 60%',
                                style: TextStyle(
                                  fontSize: rs.adaptive(
                                    mobile: 13,
                                    tablet: 14,
                                    desktop: 15,
                                  ),
                                  height: 1.35,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF5A5A5A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// BUTTONS
                    AnnouncementFixedBottomActions(
                      child: Row(
                        children: [
                          Expanded(
                            child: _BottomButton(
                              text: 'Retour',
                              isPrimary: false,
                              onPressed: () => cubit.goToStep(3),
                            ),
                          ),
                          SizedBox(width: rs.adaptive(mobile: 14, tablet: 18, desktop: 20)),
                          Expanded(
                            child: _BottomButton(
                              text: 'Suivant',
                              isPrimary: true,
                              onPressed: state.photos.length < 3
                                  ? null
                                  : () => cubit.goToStep(6),
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

class _AddPhotoBox extends StatelessWidget {
  final double size;
  final VoidCallback onTap;

  const _AddPhotoBox({
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
          ),
          border: Border.all(color: const Color(0xFFBDBDBD)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: rs.adaptive(mobile: 22, tablet: 24, desktop: 26),
              color: const Color(0xFF4A4A4A),
            ),
            SizedBox(height: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
            Text(
              'Ajouter',
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  final double size;
  final File file;
  final VoidCallback onRemove;

  const _PhotoPreview({
    required this.size,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
          ),
          child: Image.file(
            file,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(
                rs.adaptive(mobile: 4, tablet: 5, desktop: 6),
              ),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
    final rs = context.rs;

    return SizedBox(
      height: rs.adaptive(
        mobile: 46,
        tablet: 50,
        desktop: 54,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFFB7F000) : Colors.white,
          disabledBackgroundColor:
              isPrimary ? const Color(0xFFB7F000).withOpacity(0.4) : Colors.white,
          side: const BorderSide(color: Color(0xFFB7F000)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              rs.adaptive(mobile: 24, tablet: 28, desktop: 30),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: rs.adaptive(
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF222222),
          ),
        ),
      ),
    );
  }
}