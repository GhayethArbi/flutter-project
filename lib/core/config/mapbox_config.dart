class MapboxConfig {
  MapboxConfig._();

  static const String publicToken = String.fromEnvironment(
    'MAPBOX_PUBLIC_TOKEN',
  );

  static void validate() {
    if (publicToken.isEmpty) {
      throw Exception(
        'MAPBOX_PUBLIC_TOKEN is missing. '
        'Run with --dart-define=MAPBOX_PUBLIC_TOKEN=pk.xxx',
      );
    }
  }
}