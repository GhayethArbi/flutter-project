import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/forgot_password/services/forgot_password_service.dart';

import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/forgot_password_content.dart';
import '../widgets/forgot_password_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocProvider(
      create: (_) => ForgotPasswordCubit(service: ForgotPasswordService()),
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: rs.adaptive(
                      mobile: rs.w,
                      tablet: 520,
                      desktop: 560,
                    ),
                  ),
                  child: ForgotPasswordLayout(
                    showBack: state.step != ForgotPasswordStep.resetSuccess,
                    onBack: () {
                      if (state.step == ForgotPasswordStep.identifier) {
                        Navigator.pop(context);
                      } else {
                        context.read<ForgotPasswordCubit>().back();
                      }
                    },
                    child: const ForgotPasswordContent(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
