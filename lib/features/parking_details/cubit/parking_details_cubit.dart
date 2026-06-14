import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/parking_details/cubit/parking_details_state.dart';
import 'package:tunipark/features/parking_details/services/parking_interaction_api.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';

class ParkingDetailsCubit extends Cubit<ParkingDetailsState> {
  final ParkingInteractionApi interactionApi;

  ParkingDetailsCubit(ParkingPlace place, this.interactionApi)
    : super(ParkingDetailsState.initial(place)) {
    _logView();
  }
  Future<void> _logView() async {
    try {
      await interactionApi.logParkingView(state.place.id);
    } catch (e) {
      print('Failed to log parking view: $e');
    }
  }
}
