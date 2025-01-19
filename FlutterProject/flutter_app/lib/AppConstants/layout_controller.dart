class LayoutController {
  static const double _staticHeight = 800.0;
  static double getStaticHeight() {
    return _staticHeight;
  }

  static double getHeight(double height, {double? minHeight}) {
    return height >= (minHeight ?? _staticHeight)
        ? height
        : (minHeight ?? _staticHeight);
  }
}
