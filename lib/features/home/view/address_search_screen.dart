import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/address_search/address_search_cubit.dart';
import '../cubit/address_search/address_search_state.dart';
import '../../parking_map/models/selected_place.dart';
import '../services/location_search_service.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AddressSearchScreen extends StatelessWidget {
  const AddressSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddressSearchCubit(
        locationSearchService: LocationSearchService(),
      ),
      child: const _AddressSearchView(),
    );
  }
}

class _AddressSearchView extends StatefulWidget {
  const _AddressSearchView();

  @override
  State<_AddressSearchView> createState() => _AddressSearchViewState();
}

class _AddressSearchViewState extends State<_AddressSearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation(BuildContext context) async {
    final cubit = context.read<AddressSearchCubit>();

    try {
      final place = await cubit.useCurrentLocation();
      if (!mounted) return;
      Navigator.pop(context, place);
    } catch (_) {}
  }

  void _selectPlace(BuildContext context, SelectedPlace place) {
    Navigator.pop(context, place);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final horizontalPadding = rs.adaptive(
      mobile: 20,
      tablet: 28,
      desktop: 36,
    );

    final fieldHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.065), 50, 56),
      tablet: 58,
      desktop: 62,
    );

    final fieldRadius = rs.adaptive(
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );

    final textFontSize = rs.adaptive(
      mobile: 14,
      tablet: 15,
      desktop: 16,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: BlocConsumer<AddressSearchCubit, AddressSearchState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: fieldHeight,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(fieldRadius),
                            border: Border.all(
                              color: AppColors.colorBtn,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            onChanged: context
                                .read<AddressSearchCubit>()
                                .onQueryChanged,
                            style: TextStyle(
                              fontSize: textFontSize,
                              color: const Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                              labelText: AppStrings.rechercher,
                              hintStyle: TextStyle(
                                color: const Color(0xFF8B8B8B),
                                fontSize: textFontSize,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF444444),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(AppStrings.annuler,
                          style: TextStyle(
                            fontSize: rs.adaptive(
                              mobile: 15,
                              tablet: 16,
                              desktop: 17,
                            ),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: rs.adaptive(mobile: 18, tablet: 20, desktop: 24),
                  ),

                  InkWell(
                    onTap: state.status ==
                            AddressSearchStatus.currentLocationLoading
                        ? null
                        : () => _useCurrentLocation(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.my_location,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              state.status ==
                                      AddressSearchStatus.currentLocationLoading
                                  ? 'Recherche de la position actuelle...'
                                  : 'Position actuelle',
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 16,
                                  tablet: 17,
                                  desktop: 18,
                                ),
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Color(0xFFDBF08A), height: 24),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.query.trim().length < 3) {
                          if (state.recentPlaces.isEmpty) {
                            return Center(
                              child: Text(AppStrings.commencezASaisirUneAdresse,
                                style: TextStyle(
                                  fontSize: rs.adaptive(
                                    mobile: 14,
                                    tablet: 15,
                                    desktop: 16,
                                  ),
                                  color: const Color(0xFF7B7B7B),
                                ),
                              ),
                            );
                          }

                          return ListView.separated(
                            itemCount: state.recentPlaces.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 2),
                            itemBuilder: (context, index) {
                              final place = state.recentPlaces[index];
                              return _AddressTile(
                                icon: Icons.history,
                                title: place.label,
                                onTap: () => _selectPlace(context, place),
                              );
                            },
                          );
                        }

                        if (state.status == AddressSearchStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.status == AddressSearchStatus.empty) {
                          return Center(
                            child: Text(AppStrings.aucunLieuTrouve,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 17,
                                ),
                                color: const Color(0xFF7B7B7B),
                              ),
                            ),
                          );
                        }

                        if (state.status == AddressSearchStatus.failure) {
                          return Center(
                            child: Text(
                              state.errorMessage ?? 'Erreur de recherche',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 17,
                                ),
                                color: Colors.red,
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: state.suggestions.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 2),
                          itemBuilder: (context, index) {
                            final place = state.suggestions[index];
                            return _AddressTile(
                              icon: Icons.location_on_outlined,
                              title: place.label,
                              onTap: () => _selectPlace(context, place),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AddressTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF222222),
              size: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: rs.adaptive(
                    mobile: 15,
                    tablet: 16,
                    desktop: 17,
                  ),
                  color: const Color(0xFF4A4A4A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}