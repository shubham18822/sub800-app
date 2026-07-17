import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to landing screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.landing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? message = ModalRoute.of(context)?.settings.arguments as String?;

    // Simple centered text only (matches Figma design) — removed image and animations
    return Scaffold(
      backgroundColor: AppTheme.appTheme,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'sub800',
            //   style: TextStyle(
            //     fontSize: 28,
            //     fontWeight: FontWeight.w600,
            //     color: AppTheme.white,
            //     letterSpacing: 1.2,
            //   ),
            // ),

            Image.asset(
              'assets/wlogo.png',
              height: 32,
              fit: BoxFit.contain,
            ),

            // Optional small message under the centered text
            if (message != null && message.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                message,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.white.withValues(alpha: 0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

