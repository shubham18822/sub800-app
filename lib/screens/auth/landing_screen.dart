import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: size.height * 0.25),

                    // Heading
                    Text(
                      'Your Space,\nOur Services',
                      style: GoogleFonts.newsreader(
                        textStyle: AppTheme.heading1.copyWith(
                          fontSize: 59,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Manage your office space through one place via the sub800 app',
                      style: GoogleFonts.dmSans(
                        textStyle: AppTheme.subtitle.copyWith(
                          // keep subtitle color from AppTheme.subtitle
                          color: AppTheme.lightGray,
                          fontStyle: FontStyle.normal,
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                // Buttons at bottom
                Column(
                  children: [
                    SizedBox(
                      width: 185,
                      height: 40,
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
                        child: Text('Log In', style: AppTheme.buttonText.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w400, fontSize: 13)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: 185,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                          // Just browsing - no navigation for now
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          foregroundColor: AppTheme.primaryTeal,
                          elevation: 3,
                          side: const BorderSide(color: AppTheme.white, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        ),
                        child: Text('Just Browsing', style: AppTheme.bodyRegular.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w400, fontSize: 13)),
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

