import 'package:equatable/equatable.dart';

class MainNavState extends Equatable {
  final int currentIndex;

  const MainNavState({
    this.currentIndex = 0,
  });

  MainNavState copyWith({
    int? currentIndex,
  }) {
    return MainNavState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}