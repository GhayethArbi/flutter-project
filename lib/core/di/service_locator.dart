import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunipark/core/constants/app_constants.dart';
import 'package:tunipark/core/network/dio_client.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/features/announcement/services/parking_service.dart';
import 'package:tunipark/features/bookings/services/booking_service.dart';
import 'package:tunipark/features/login/services/login_service.dart';
import 'package:tunipark/features/my_lots/services/my_lots_service.dart';
import 'package:tunipark/features/notification/services/fcm_service.dart';
import 'package:tunipark/features/notification/services/notification_service.dart';
import 'package:tunipark/features/parking_booking_flow/services/parking_session_service.dart';
import 'package:tunipark/features/parking_booking_flow/services/payment_service.dart';
import 'package:tunipark/features/parking_details/services/parking_interaction_api.dart';
import 'package:tunipark/features/parking_map/services/parking_map_service.dart';
import 'package:tunipark/features/personal_information/services/user_service.dart';
import 'package:tunipark/features/security/service/change_password_service.dart';
import 'package:tunipark/features/signup/services/signup_service.dart';

class ServiceLocator {
  ServiceLocator._({
    required this.parkingMapService,
    required this.changePasswordService,
    required this.authStorageService,
    required this.dio,
    required this.loginService,
    required this.signUpService,
    required this.userService,
    required this.parkingService,

    required this.parkingSessionService,
    required this.paymentService,
    required this.myLotsService,
    required this.bookingService,
    required this.parkingInteractionApi,
    required this.notificationService,
    required this.fcmService,
  });

  factory ServiceLocator.create({void Function()? onSessionExpired}) {
    final authStorageService = AuthStorageService(
      storage: const FlutterSecureStorage(),
    );

    final dio = DioClient.create(
      baseUrl: AppConstants.baseUrlNest,
      authStorageService: authStorageService,
      onSessionExpired: onSessionExpired,
    );
    final notificationService = NotificationService(dio: dio);
    return ServiceLocator._(
      authStorageService: authStorageService,
      dio: dio,
      loginService: LoginService(dio: dio),
      signUpService: SignUpService(dio: dio),
      userService: UserService(dio: dio),
      changePasswordService: ChangePasswordService(dio: dio),
      parkingService: ParkingService(dio: dio),
      parkingMapService: ParkingMapService(dio: dio),
      parkingSessionService: ParkingSessionService(dio: dio),
      paymentService: PaymentService(dio: dio),
      myLotsService: MyLotsService(dio: dio), // ← ADD
      bookingService: BookingService(dio: dio),
      parkingInteractionApi: ParkingInteractionApi(dio: dio),
      notificationService: notificationService,
      fcmService: FcmService(notificationService: notificationService),
    );
  }

  final AuthStorageService authStorageService;
  final Dio dio;
  final ParkingMapService parkingMapService;
  final LoginService loginService;
  final SignUpService signUpService;
  final UserService userService;
  final ChangePasswordService changePasswordService;
  final ParkingService parkingService;

  final ParkingSessionService parkingSessionService;
  final PaymentService paymentService;
  final MyLotsService myLotsService;
  final BookingService bookingService;
  final ParkingInteractionApi parkingInteractionApi;
  final NotificationService notificationService;
  final FcmService fcmService;
}
