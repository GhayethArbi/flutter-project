import 'package:equatable/equatable.dart';
import 'package:tunipark/core/models/user_model.dart';
import 'package:tunipark/features/profile/models/profile_menu_item.dart';
import 'package:tunipark/features/profile/models/profile_promo_card_model.dart';

enum ProfileStatus { initial, signingOut, signedOut, failure }

enum AppThemeMode { day, night }

class ProfileState extends Equatable {
  const ProfileState({
    required this.themeMode,
    required this.greetingPrefix,
    required this.greetingHighlight,
    required this.selectedBottomNavIndex,
    required this.accountItems,
    required this.discoverItems,
    required this.helpItems,
    required this.referralCard,
    required this.professionalCard,
    this.isSigningOut = false,
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.user,
  });
  final AppThemeMode themeMode;
  final String greetingPrefix;
  final String greetingHighlight;
  final int selectedBottomNavIndex;
  final List<ProfileMenuItem> accountItems;
  final List<ProfileMenuItem> discoverItems;
  final List<ProfileMenuItem> helpItems;
  final ProfilePromoCardModel referralCard;
  final ProfilePromoCardModel professionalCard;
  final bool isSigningOut;
  final ProfileStatus status;
  final String? errorMessage;
  final UserModel? user;

  ProfileState copyWith({
    AppThemeMode? themeMode,
    String? greetingPrefix,
    String? greetingHighlight,
    int? selectedBottomNavIndex,
    List<ProfileMenuItem>? accountItems,
    List<ProfileMenuItem>? discoverItems,
    List<ProfileMenuItem>? helpItems,
    ProfilePromoCardModel? referralCard,
    ProfilePromoCardModel? professionalCard,
    bool? isSigningOut,
    ProfileStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
      UserModel? user,
  }) {
    return ProfileState(
      themeMode: themeMode ?? this.themeMode,
      greetingPrefix: greetingPrefix ?? this.greetingPrefix,
      greetingHighlight: greetingHighlight ?? this.greetingHighlight,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      accountItems: accountItems ?? this.accountItems,
      discoverItems: discoverItems ?? this.discoverItems,
      helpItems: helpItems ?? this.helpItems,
      referralCard: referralCard ?? this.referralCard,
      professionalCard: professionalCard ?? this.professionalCard,
      isSigningOut: isSigningOut ?? this.isSigningOut,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
            user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    themeMode,
    greetingPrefix,
    greetingHighlight,
    selectedBottomNavIndex,
    accountItems,
    discoverItems,
    helpItems,
    referralCard,
    professionalCard,
    isSigningOut,
    status,
    errorMessage,
    user,
  ];
}
