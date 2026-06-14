// Pure data class — no Flutter widgets, no imports needed beyond dart:core
class ParkingLayout {
  final double screenW;
  final double screenH;
  final double rightPadding;
  final double vLineW;
  final double rightColW;
  final double leftLaneW;
  final double topInset;
  final double bottomInset;
  final double rowH;
  final double carW;
  final double carH;
  final double hLineH;
  final double parkedCarLeft;

  ParkingLayout._({
    required this.screenW,
    required this.screenH,
    required this.rightPadding,
    required this.vLineW,
    required this.rightColW,
    required this.leftLaneW,
    required this.topInset,
    required this.bottomInset,
    required this.rowH,
    required this.carW,
    required this.carH,
    required this.hLineH,
    required this.parkedCarLeft,
  });

  static ParkingLayout compute({
    required double screenW,
    required double screenH,
    required int rows,
  }) {
    final rightPadding = (screenW * 0.04).clamp(10.0, 18.0);
    final vLineW      = (screenW * 0.012).clamp(3.0, 7.0);
    final rightColW   = screenW * 0.5;
    final leftLaneW   = screenW - rightPadding - vLineW - rightColW;
    final topInset    = (screenH * 0.06).clamp(16.0, 34.0);
    final bottomInset = (screenH * 0.06).clamp(16.0, 34.0);
    final usableH     = (screenH - topInset - bottomInset).clamp(200.0, double.infinity);
    final rowH        = usableH / rows;
    final carH        = rowH * 0.75;
    final carW        = rightColW;
    final hLineH      = rowH * 0.04;
    final parkedCarLeft = leftLaneW + (rightColW - carW);

    return ParkingLayout._(
      screenW: screenW,
      screenH: screenH,
      rightPadding: rightPadding,
      vLineW: vLineW,
      rightColW: rightColW,
      leftLaneW: leftLaneW,
      topInset: topInset,
      bottomInset: bottomInset,
      rowH: rowH,
      carW: carW,
      carH: carH,
      hLineH: hLineH,
      parkedCarLeft: parkedCarLeft,
    );
  }

  double rowCenterY(int index0Based) =>
      topInset + (index0Based + 0.5) * rowH;
}