import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'screens/auth/loading_screen.dart';

void main() {
  // Keep Google Fonts deterministic in release (no runtime network fetch fallback).
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub800',
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            // Prevent unexpected line breaks due to device accessibility text scaling.
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppTheme.appTheme,
        scaffoldBackgroundColor: AppTheme.appTheme,
      ),
      home: const LoadingScreen(),
      routes: Routes.getRoutes(),
    );
  }
}