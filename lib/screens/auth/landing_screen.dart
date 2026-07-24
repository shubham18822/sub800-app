import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../utils/responsive.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.appTheme,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.04),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height - MediaQuery.of(context).padding.vertical),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/wlogo.png',
                      height: context.rh(32),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: size.height * 0.16),

                    // Heading
                    Text(
                      'Your Space,\nOur Services',
                      textScaler: const TextScaler.linear(1.0),
                      maxLines: 2,
                      style: AppTheme.newsreader(
                        fontSize: context.rf(59, minScale: 0.6, maxScale: 1.0),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.white,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Manage your office space through one place via the sub800 app',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(16),
                        fontWeight: FontWeight.w400,
                        color: AppTheme.lightGray,
                      ),
                    ),
                  ],
                ),

                // Buttons at bottom
                Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.55,
                      height: context.rh(40),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate immediately to login screen
                          Navigator.pushNamed(context, Routes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          foregroundColor: AppTheme.primaryTeal,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        ),
                        child: Text('Log In', style: AppTheme.buttonText.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w400, fontSize: context.rf(13))),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.55,
                      height: context.rh(40),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.home);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          foregroundColor: AppTheme.primaryTeal,
                          elevation: 3,
                          side: const BorderSide(color: AppTheme.white, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        ),
                        child: Text('Just Browsing', style: AppTheme.bodyRegular.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w400, fontSize: context.rf(13))),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

