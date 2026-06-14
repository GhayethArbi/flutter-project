import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final int total;

  const OnboardingState({
    required this.currentIndex,
    required this.total,
  });

  bool get isFirst => currentIndex == 0;
  bool get isLast  => currentIndex == total - 1;

  OnboardingState copyWith({int? currentIndex}) => OnboardingState(
        currentIndex: currentIndex ?? this.currentIndex,
        total: total,
      );

  @override
  List<Object> get props => [currentIndex, total];
}