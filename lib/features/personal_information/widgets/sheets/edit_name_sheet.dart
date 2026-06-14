import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';
import 'package:tunipark/features/personal_information/sheet_widgets.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';

/// Bottom sheet for editing first name + last name.
///
/// Opens via [EditNameSheet.show]. Closes itself on [PersonalInfoStatus.success].
class EditNameSheet extends StatefulWidget {
  const EditNameSheet({
    super.key,
    required this.cubit,
    required this.initialFirst,
    required this.initialLast,
  });

  final PersonalInfoCubit cubit;
  final String initialFirst;
  final String initialLast;

  /// Convenience factory — handles [BlocProvider.value] boilerplate.
  static void show(
    BuildContext context, {
    required PersonalInfoCubit cubit,
    required String initialFirst,
    required String initialLast,
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
        child: EditNameSheet(
          cubit: cubit,
          initialFirst: initialFirst,
          initialLast: initialLast,
        ),
      ),
    );
  }

  @override
  State<EditNameSheet> createState() => _EditNameSheetState();
}

class _EditNameSheetState extends State<EditNameSheet> {
  late final TextEditingController _firstCtrl;
  late final TextEditingController _lastCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstCtrl = TextEditingController(text: widget.initialFirst);
    _lastCtrl = TextEditingController(text: widget.initialLast);
  }

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.cubit.updateField(
      firstName: _firstCtrl.text.trim(),
      lastName: _lastCtrl.text.trim(),
    );
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
                const SheetTitle(title: 'Modifier le nom'),
                const SizedBox(height: 20),

                const AppFieldLabel(label: 'Prénom'),
                SheetTextField(
                  controller: _firstCtrl,
                  hint: 'Votre prénom',
                  textInputAction: TextInputAction.next,
                  capitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),

                const AppFieldLabel(label: 'Nom'),
                SheetTextField(
                  controller: _lastCtrl,
                  hint: 'Votre nom',
                  textInputAction: TextInputAction.done,
                  capitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 24),

                AppPrimaryButton(
                  label: 'Enregistrer',
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