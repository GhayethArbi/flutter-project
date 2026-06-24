// lib/features/bookings/utils/maps_launcher.dart
//
// Opens the device's default maps app with directions to a parking spot.
//  - Android: `geo:` URI, resolved by the OS to whichever maps app
//    the user has installed/preferred.
//  - iOS: Apple Maps web link (no app-installed check needed — it's a
//    plain https:// URL that iOS always knows how to open).
//  - Anything else (desktop/web): falls back to Google Maps web.

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapsLauncher {
  const MapsLauncher._();

  /// Returns true if a maps app/browser was successfully opened.
  static Future<bool> openDirections({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final encodedLabel =
        label != null && label.isNotEmpty ? Uri.encodeComponent(label) : null;

    if (Platform.isAndroid) {
      final query = encodedLabel != null
          ? '$latitude,$longitude($encodedLabel)'
          : '$latitude,$longitude';
      final geoUri = Uri.parse('geo:$latitude,$longitude?q=$query');

      if (await canLaunchUrl(geoUri)) {
        return launchUrl(geoUri, mode: LaunchMode.externalApplication);
      }
    }

    if (Platform.isIOS) {
      final appleMapsUri = Uri.parse(
        'https://maps.apple.com/?daddr=$latitude,$longitude'
        '${encodedLabel != null ? '&q=$encodedLabel' : ''}',
      );
      final launched = await launchUrl(
        appleMapsUri,
        mode: LaunchMode.externalApplication,
      );
      if (launched) return true;
    }

    // Fallback: Google Maps web URL, works in a browser on any platform.
    final webUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
    );

    return launchUrl(webUri, mode: LaunchMode.externalApplication);
  }
}