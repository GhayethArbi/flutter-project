import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';
import 'package:tunipark/features/personal_information/sheet_widgets.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';

/// Bottom sheet for changing the e-mail address.
///
/// Shows a confirmation-link hint. Closes itself on [PersonalInfoStatus.success].
class EditEmailSheet extends StatefulWidget {
  const EditEmailSheet({
    super.key,
    required this.cubit,
    required this.initialEmail,
  });

  final PersonalInfoCubit cubit;
  final String initialEmail;

  static void show(
    BuildContext context, {
    required PersonalInfoCubit cubit,
    required String initialEmail,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTokens.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: EditEmailSheet(cubit: cubit, initialEmail: initialEmail),
      ),
    );
  }

  @override
  State<EditEmailSheet> createState() => _EditEmailSheetState();
}

class _EditEmailSheetState extends State<EditEmailSheet> {
  late final TextEditingController _ctrl;
  final _formKey = GlobalKey<FormState>();

  // Simple email regex — adjust if you have a shared validator elsewhere.
  static final _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.cubit.updateField(email: _ctrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {
        if (state.isSuccess) Navigator.pop(context);
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SheetHandle(),
                const SizedBox(height: 16),
                const SheetTitle(title: "Modifier l'e-mail"),
                const SizedBox(height: 8),
                const SheetSubtitle(
                  text: 'Un lien de confirmation sera envoyé à votre nouvelle adresse.',
                ),
                const SizedBox(height: 20),

                const AppFieldLabel(label: 'Adresse e-mail'),
                SheetTextField(
                  controller: _ctrl,
                  hint: 'exemple@email.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Champ requis';
                    if (!_emailRegex.hasMatch(v.trim())) return 'Adresse e-mail invalide';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                AppPrimaryButton(
                  label: 'Envoyer le lien',
                  isLoading: state.isSaving,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}