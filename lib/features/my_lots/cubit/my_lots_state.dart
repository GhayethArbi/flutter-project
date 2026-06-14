import 'package:equatable/equatable.dart';
import '../models/my_lot_model.dart';

enum MyLotsStatus { initial, loading, success, failure }

class MyLotsState extends Equatable {
  const MyLotsState({
    this.status = MyLotsStatus.initial,
    this.lots = const [],
    this.errorMessage,
  });

  final MyLotsStatus status;
  final List<MyLotModel> lots;
  final String? errorMessage;

  bool get isLoading => status == MyLotsStatus.loading;
  bool get isEmpty =>
      status == MyLotsStatus.success && lots.isEmpty;

  MyLotsState copyWith({
    MyLotsStatus? status,
    List<MyLotModel>? lots,
    String? errorMessage,
  }) {
    return MyLotsState(
      status: status ?? this.status,
      lots: lots ?? this.lots,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, lots, errorMessage];
}