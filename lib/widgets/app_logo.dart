import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class AppLogo extends StatelessWidget {
  final double? height;

  const AppLogo({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: height ?? context.rh(32),
      fit: BoxFit.contain,
    );
  }
}

