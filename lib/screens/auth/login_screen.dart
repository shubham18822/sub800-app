import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import '../../utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.appTheme,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo (small top-left)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/wlogo.png',
                      height: context.rh(32),
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8),
                    // Text(
                    //   'sub800',
                    //   style: AppTheme.bodyRegular.copyWith(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: size.height * 0.10),

                // Main Heading (serif, italic) — match Figma: "Your Space,\nOur Services"
                Text(
                  'Welcome\nback,',
                  style: AppTheme.newsreader(
                    fontSize: context.rf(59, minScale: 0.6, maxScale: 1.0),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                // Subtitle / description
                Text(
                  'Manage your office space through one place via the sub800 app',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(16),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.lightGray,
                  ),
                ),
                SizedBox(height: size.height * 0.06),

                // Email Label
                // Text(
                  //'Email',
                //   style: AppTheme.bodySmall.copyWith(
                //     color: AppTheme.white,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // SizedBox(height: size.height * 0.01),

                // Email Input
            SizedBox(
              height: context.rh(42),
              child:TextField(
                  controller: _emailController,
                  style: AppTheme.bodyRegular,
                  cursorColor: AppTheme.white,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: AppTheme.dmSans(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.white.withValues(alpha: 0.9),
                    ),
                    filled: true,
                    fillColor: AppTheme.appTheme.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.white,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.white,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.010,
                    ),
                  ),
                ),
            ),
                SizedBox(height: size.height * 0.01),

                // Password Label
                // Text(
                //   'Password',
                //   style: AppTheme.bodySmall.copyWith(
                //     color: AppTheme.white,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // SizedBox(height: size.height * 0.01),

                // Password Input
            SizedBox(
              height: context.rh(42),
              child: TextField(
                  controller: _passwordController,
                  style: AppTheme.bodyRegular,
                  obscureText: true,
                  cursorColor: AppTheme.white,
                  decoration: InputDecoration(
                    hintText: 'sub800 Provided Code',
                    hintStyle: AppTheme.dmSans(
                      fontSize: context.rf(16),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.white.withValues(alpha: 0.9),
                    ),
                    filled: true,
                    fillColor: AppTheme.appTheme.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: AppTheme.white,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.010,
                    ),
                  ),
                ),
            ),
                SizedBox(height: size.height * 0.03),

                // Forgot Password Link
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: GestureDetector(
                //     onTap: () {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Forgot password functionality coming soon')),
                //       );
                //     },
                //     child: Text(
                //       'Forgot Password?',
                //       style: AppTheme.bodySmall.copyWith(
                //         color: AppTheme.white,
                //         decoration: TextDecoration.underline,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: size.height * 0.06),

                // Login Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: size.width * 0.55,
                    height: context.rh(40),
                    child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Home screen after login
                      Navigator.pushReplacementNamed(context, Routes.home);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Log In',
                      style: AppTheme.buttonText.copyWith(
                        color: AppTheme.primaryTeal,
                        fontSize: context.rf(13),
                        fontWeight: FontWeight.w400,
                      ),
                     ),
                   ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),

                // White Horizontal Divider Line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppTheme.white.withValues(alpha: 0.4),
                ),
                SizedBox(height: size.height * 0.05),

                // Create Account Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: size.width * 0.55,
                    height: context.rh(40),
                    child: ElevatedButton(
                    onPressed: () {
                      // Navigate to create account screen
                      Navigator.pushNamed(context, '/create_account');
                    },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppTheme.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(0),
                       ),
                       elevation: 2,
                     ),
                    child: Text(
                      'Create Account',
                      style: AppTheme.buttonText.copyWith(
                        color: AppTheme.primaryTeal,
                        fontSize: context.rf(12),
                      ),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

