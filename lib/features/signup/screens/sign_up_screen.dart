import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/signup/widgets/signup_step1.dart';
import 'package:tunipark/features/signup/widgets/signup_step2.dart';
import 'package:tunipark/features/signup/widgets/signup_success.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';


class SignUpScreen extends StatelessWidget {
  final void Function(BuildContext context)? onSuccess;

  const SignUpScreen({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        switch (state.step) {
          case SignUpStep.info:
            return const SignUpStep1();

          case SignUpStep.password:
            return const SignUpStep2();

          case SignUpStep.success:
            return const SignUpSuccess();
        }
      },
    );
  }
}
