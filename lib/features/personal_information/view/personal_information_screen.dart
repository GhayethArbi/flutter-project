import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';
import 'package:tunipark/features/personal_information/services/user_service.dart';
import 'package:tunipark/features/personal_information/view/personal_info_body.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';
import '../widgets/loading_skeleton.dart';
import 'package:tunipark/core/constants/app_strings.dart';

/// Receives its dependencies from the router — no internal construction.
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({
    super.key,
    required this.userService,
    required this.authStorageService,
  });

  final UserService userService;
  final AuthStorageService authStorageService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalInfoCubit(
        authStorageService: authStorageService,
        userService: userService,
      )..loadProfile(),
      child: const _PersonalInfoView(),
    );
  }
}

class _PersonalInfoView extends StatelessWidget {
  const _PersonalInfoView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: _handleSideEffects,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTokens.background,
          body: SafeArea(
            child: Column(
              children: [
                const AppScreenHeader(title: 'Informations personnelles'),
                Expanded(
                  child: state.isLoading
                      ? const LoadingSkeleton()
                      : PersonalInfoBody(state: state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleSideEffects(BuildContext context, PersonalInfoState state) {
    if (state.isSuccess) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(AppStrings.informationsMisesAJour),
            backgroundColor: AppTokens.limeDark,
          ),
        );
      context.read<PersonalInfoCubit>().resetStatus();
    }

    if (state.hasError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? 'Erreur'),
            backgroundColor: AppTokens.danger,
          ),
        );
    }
  }
}