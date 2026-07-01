import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/signup/widgets/signup_text_field.dart';
import 'package:tunipark/features/signup/cubit/signup_cubit.dart';
import 'package:tunipark/features/signup/widgets/signup_button.dart';
import 'package:tunipark/features/signup/widgets/signup_header.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({super.key});

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;

  final _lastNameNode  = FocusNode();
  final _firstNameNode = FocusNode();
  final _emailNode     = FocusNode();
  final _phoneNode     = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize with whatever is already in the cubit state
    final s = context.read<SignUpCubit>().state;
    _lastNameCtrl  = TextEditingController(text: s.lastName);
    _firstNameCtrl = TextEditingController(text: s.firstName);
    _emailCtrl     = TextEditingController(text: s.email);
    _phoneCtrl     = TextEditingController(text: s.phone);
  }

  @override
  void dispose() {
    _lastNameCtrl.dispose();
    _firstNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _lastNameNode.dispose();
    _firstNameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    final state = context.watch<SignUpCubit>().state;
    final theme = Theme.of(context);
    final rs    = context.rs;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: rs.clampSize(0.07, 22, 36)),
          child: Column(
            children: [
              SizedBox(height: rs.clampSize(0.10, 32, 56)),
              const SignUpHeader(),
              SizedBox(height: rs.clampSize(0.08, 28, 44)),

              Row(
                children: [
                  Expanded(
                    child: SignUpTextField(
                      hint: 'Nom',
                      controller: _lastNameCtrl,
                      errorText: state.lastNameError,
                      focusNode: _lastNameNode,
                      textInputAction: TextInputAction.next,
                      onChanged: cubit.lastNameChanged,
                      onSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_firstNameNode),
                    ),
                  ),
                  SizedBox(width: rs.clampSize(0.03, 10, 16)),
                  Expanded(
                    child: SignUpTextField(
                      hint: 'Prénom',
                      controller: _firstNameCtrl,
                      errorText: state.firstNameError,
                      focusNode: _firstNameNode,
                      textInputAction: TextInputAction.next,
                      onChanged: cubit.firstNameChanged,
                      onSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_emailNode),
                    ),
                  ),
                ],
              ),

              SizedBox(height: rs.clampSize(0.035, 12, 18)),

              SignUpTextField(
                hint: 'E-mail',
                controller: _emailCtrl,
                errorText: state.emailError,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailNode,
                textInputAction: TextInputAction.next,
                onChanged: cubit.emailChanged,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_phoneNode),
              ),

              SizedBox(height: rs.clampSize(0.035, 12, 18)),

              SignUpTextField(
                hint: 'Numéro de téléphone',
                controller: _phoneCtrl,
                errorText: state.phoneError,
                keyboardType: TextInputType.phone,
                focusNode: _phoneNode,
                textInputAction: TextInputAction.done,
                onChanged: cubit.phoneChanged,
                onSubmitted: (_) {
                  _phoneNode.unfocus();
                  cubit.nextStep();
                },
              ),

              SizedBox(height: rs.clampSize(0.09, 36, 56)),

              SignUpButton(
                label: AppStrings.suivant,
                isLoading: false,
                onTap: cubit.nextStep,
              ),

              SizedBox(height: rs.clampSize(0.07, 24, 36)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.vousAvezUnCompte,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: rs.clampSize(0.035, 13, 15),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(AppStrings.seConnecter2,
                      style: TextStyle(
                        color: AppColors.colorBtn,
                        fontSize: rs.clampSize(0.035, 13, 15),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: rs.clampSize(0.05, 18, 28)),
            ],
          ),
        ),
      ),
    );
  }
}