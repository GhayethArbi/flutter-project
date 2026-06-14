import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/login/services/login_service.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatelessWidget {
  final void Function(BuildContext context)? onSuccess;

  const LoginScreen({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        loginService: LoginService(dio: Dio()),
        authStorageService: const AuthStorageService(
          storage: FlutterSecureStorage(),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            onSuccess?.call(context);
          }

          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Erreur de connexion'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final rs = context.rs;

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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: rs.adaptive(
                        mobile: 30,
                        tablet: 40,
                        desktop: 48,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: rs.adaptive(
                            mobile: 44,
                            tablet: 60,
                            desktop: 72,
                          ),
                        ),
                        const LoginHeader(),
                        SizedBox(
                          height: rs.adaptive(
                            mobile: 34,
                            tablet: 42,
                            desktop: 48,
                          ),
                        ),
                        const LoginForm(),
                        SizedBox(
                          height: rs.adaptive(
                            mobile: 70,
                            tablet: 80,
                            desktop: 90,
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
      ),
    );
  }
}