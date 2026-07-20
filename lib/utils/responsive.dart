import 'dart:math' as math;

import 'package:flutter/widgets.dart';

extension ResponsiveSizing on BuildContext {
  static const double _baseWidth = 390;
  static const double _baseHeight = 844;

  Size get screenSize => MediaQuery.sizeOf(this);

  bool get isSmallPhone => screenSize.width < 360;

  double rw(double value, {double minScale = 0.82, double maxScale = 1.2}) {
    final scaled = value * (screenSize.width / _baseWidth);
    return scaled.clamp(value * minScale, value * maxScale);
  }

  double rh(double value, {double minScale = 0.82, double maxScale = 1.2}) {
    final scaled = value * (screenSize.height / _baseHeight);
    return scaled.clamp(value * minScale, value * maxScale);
  }

  double rf(double value, {double minScale = 0.86, double maxScale = 1.18}) {
    final shortestSide = math.min(screenSize.width, screenSize.height);
    final scaled = value * (shortestSide / _baseWidth);
    return scaled.clamp(value * minScale, value * maxScale);
  }
}

