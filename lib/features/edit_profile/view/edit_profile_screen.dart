import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:tunipark/features/edit_profile/cubit/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final cubit = context.read<EditProfileCubit>();

            return Stack(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: rs.adaptive(
                        mobile: rs.w,
                        tablet: 620,
                        desktop: 720,
                      ),
                    ),
                    child: Column(
                      children: [
                        const _Header(),

                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: rs.adaptive(
                                mobile: 20,
                                tablet: 32,
                                desktop: 40,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: rs.adaptive(
                                    mobile: 20,
                                    tablet: 28,
                                    desktop: 34,
                                  ),
                                ),

                                _Field(
                                  label: 'Nom',
                                  hint: 'Nom',
                                  onChanged: cubit.updateFirstName,
                                ),

                                _Field(
                                  label: 'Prénom',
                                  hint: 'Prénom',
                                  onChanged: cubit.updateLastName,
                                ),

                                _Field(
                                  label: 'Adresse mail',
                                  hint: 'E-mail',
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: cubit.updateEmail,
                                ),

                                _Field(
                                  label: 'Numéro de téléphone',
                                  hint: 'Numéro de téléphone',
                                  keyboardType: TextInputType.phone,
                                  onChanged: cubit.updatePhone,
                                ),

                                SizedBox(
                                  height: rs.adaptive(
                                    mobile: 8,
                                    tablet: 12,
                                    desktop: 16,
                                  ),
                                ),

                                _Field(
                                  label: 'Mot de passe',
                                  hint: 'Mot de passe actuel',
                                  onChanged: cubit.updateCurrentPassword,
                                  obscure: true,
                                ),

                                rs.isMobile
                                    ? Column(
                                        children: [
                                          _SmallField(
                                            hint: 'Nouveau mot de passe',
                                            onChanged: cubit.updateNewPassword,
                                          ),
                                          SizedBox(
                                            height: rs.adaptive(
                                              mobile: 14,
                                              tablet: 16,
                                              desktop: 18,
                                            ),
                                          ),
                                          _SmallField(
                                            hint: 'Réinitialiser mot de passe',
                                            onChanged: (_) {},
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: _SmallField(
                                              hint: 'Nouveau mot de passe',
                                              onChanged:
                                                  cubit.updateNewPassword,
                                            ),
                                          ),
                                          SizedBox(
                                            width: rs.adaptive(
                                              mobile: 10,
                                              tablet: 16,
                                              desktop: 20,
                                            ),
                                          ),
                                          Expanded(
                                            child: _SmallField(
                                              hint:
                                                  'Réinitialiser mot de passe',
                                              onChanged: (_) {},
                                            ),
                                          ),
                                        ],
                                      ),

                                SizedBox(
                                  height: rs.adaptive(
                                    mobile: 30,
                                    tablet: 38,
                                    desktop: 44,
                                  ),
                                ),

                                Center(
                                  child: SizedBox(
                                    width: rs.adaptive(
                                      mobile: double.infinity,
                                      tablet: 320,
                                      desktop: 360,
                                    ),
                                    height: rs.adaptive(
                                      mobile: 52,
                                      tablet: 54,
                                      desktop: 56,
                                    ),
                                    child: ElevatedButton(
                                      onPressed:
                                          state.isValid ? cubit.submit : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFB7F000),
                                        disabledBackgroundColor:
                                            const Color(0xFFB7F000)
                                                .withOpacity(0.4),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: Text(
                                        'Confirmer',
                                        style: TextStyle(
                                          fontSize: rs.adaptive(
                                            mobile: 16,
                                            tablet: 17,
                                            desktop: 18,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: rs.adaptive(
                                    mobile: 24,
                                    tablet: 32,
                                    desktop: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(),
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
    final rs = context.rs;

    return SizedBox(
      height: rs.adaptive(
        mobile: 56,
        tablet: 64,
        desktop: 70,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: rs.adaptive(
                  mobile: 20,
                  tablet: 22,
                  desktop: 24,
                ),
              ),
            ),
          ),
          Text(
            'Editer le profil',
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
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const _Field({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: rs.adaptive(
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),

        SizedBox(
          height: rs.adaptive(
            mobile: 6,
            tablet: 8,
            desktop: 10,
          ),
        ),

        TextField(
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: rs.adaptive(
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            color: const Color(0xFF222222),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: rs.adaptive(
                mobile: 13,
                tablet: 14,
                desktop: 15,
              ),
              color: const Color(0xFF888888),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: rs.adaptive(
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              vertical: rs.adaptive(
                mobile: 15,
                tablet: 17,
                desktop: 18,
              ),
            ),
            border: _border(context),
            enabledBorder: _border(context),
            focusedBorder: _border(context, focused: true),
          ),
        ),

        SizedBox(
          height: rs.adaptive(
            mobile: 14,
            tablet: 18,
            desktop: 20,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(
    BuildContext context, {
    bool focused = false,
  }) {
    final rs = context.rs;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        rs.adaptive(
          mobile: 10,
          tablet: 12,
          desktop: 14,
        ),
      ),
      borderSide: BorderSide(
        color: const Color(0xFFD5EB63),
        width: focused ? 1.4 : 1.1,
      ),
    );
  }
}

class _SmallField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;

  const _SmallField({
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return TextField(
      onChanged: onChanged,
      obscureText: true,
      style: TextStyle(
        fontSize: rs.adaptive(
          mobile: 14,
          tablet: 15,
          desktop: 16,
        ),
        color: const Color(0xFF222222),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: rs.adaptive(
            mobile: 12,
            tablet: 13,
            desktop: 14,
          ),
          color: const Color(0xFF888888),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(
            mobile: 14,
            tablet: 16,
            desktop: 18,
          ),
          vertical: rs.adaptive(
            mobile: 15,
            tablet: 17,
            desktop: 18,
          ),
        ),
        border: _border(context),
        enabledBorder: _border(context),
        focusedBorder: _border(context, focused: true),
      ),
    );
  }

  OutlineInputBorder _border(
    BuildContext context, {
    bool focused = false,
  }) {
    final rs = context.rs;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        rs.adaptive(
          mobile: 10,
          tablet: 12,
          desktop: 14,
        ),
      ),
      borderSide: BorderSide(
        color: const Color(0xFFD5EB63),
        width: focused ? 1.4 : 1.1,
      ),
    );
  }
}