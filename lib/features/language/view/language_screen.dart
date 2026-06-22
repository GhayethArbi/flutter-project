import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/language/cubit/language_cubit.dart';
import 'package:tunipark/features/language/cubit/language_state.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LanguageView();
  }
}

class _LanguageView extends StatelessWidget {
  const _LanguageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return Column(
              children: [
                const _Header(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 34, 28, 0),
                  child: Column(
                    children: [
                      _LanguageOptionTile(
                        title: AppStrings.francais,
                        isSelected:
                            state.selectedLanguage == AppLanguage.french,
                        onTap: () => context
                            .read<LanguageCubit>()
                            .selectLanguage(AppLanguage.french),
                      ),
                      const SizedBox(height: 16),
                      _LanguageOptionTile(
                        title: AppStrings.english,
                        isSelected:
                            state.selectedLanguage == AppLanguage.english,
                        onTap: () => context
                            .read<LanguageCubit>()
                            .selectLanguage(AppLanguage.english),
                      ),
                      const SizedBox(height: 16),
                      _LanguageOptionTile(
                        title: AppStrings.text,
                        isSelected:
                            state.selectedLanguage == AppLanguage.arabic,
                        onTap: () => context
                            .read<LanguageCubit>()
                            .selectLanguage(AppLanguage.arabic),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Text(AppStrings.langue,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOptionTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB7F000), width: 1.8),
              color: Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFB7F000),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
