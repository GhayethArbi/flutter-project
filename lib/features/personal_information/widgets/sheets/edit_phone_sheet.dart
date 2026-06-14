import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';
import 'package:tunipark/features/personal_information/sheet_widgets.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';

/// Bottom sheet for editing the phone number.
///
/// Shows an SMS-verification hint. Closes itself on [PersonalInfoStatus.success].
class EditPhoneSheet extends StatefulWidget {
  const EditPhoneSheet({
    super.key,
    required this.cubit,
    required this.initialPhone,
  });

  final PersonalInfoCubit cubit;
  final String initialPhone;

  static void show(
    BuildContext context, {
    required PersonalInfoCubit cubit,
    required String initialPhone,
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
        child: EditPhoneSheet(cubit: cubit, initialPhone: initialPhone),
      ),
    );
  }

  @override
  State<EditPhoneSheet> createState() => _EditPhoneSheetState();
}

class _EditPhoneSheetState extends State<EditPhoneSheet> {
  late final TextEditingController _ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialPhone);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.cubit.updateField(phone: _ctrl.text.trim());
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
                const SheetTitle(title: 'Modifier le téléphone'),
                const SizedBox(height: 8),
                const SheetSubtitle(
                  text: 'Un code de vérification sera envoyé par SMS pour confirmer.',
                ),
                const SizedBox(height: 20),

                const AppFieldLabel(label: 'Numéro de téléphone'),
                SheetTextField(
                  controller: _ctrl,
                  hint: '+216 XX XXX XXX',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 +]')),
                  ],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Champ requis';
                    if (v.trim().length < 8) return 'Numéro invalide';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                AppPrimaryButton(
                  label: 'Envoyer le code',
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