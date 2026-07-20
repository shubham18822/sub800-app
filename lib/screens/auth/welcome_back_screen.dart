import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/responsive.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.primaryTeal,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                SizedBox(height: size.height * 0.04),
                Image.asset(
                  'assets/wlogo.png',
                  height: context.rh(32),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: size.height * 0.08),

                // Greeting
                Text(
                  'Welcome back,',
                  style: AppTheme.heading2,
                ),
                SizedBox(height: size.height * 0.02),

                // Subtitle
                Text(
                  'Good to see you again! Log in to continue',
                  style: AppTheme.subtitle,
                ),
                SizedBox(height: size.height * 0.06),

                // Email Display (as read-only)
                Text(
                  'Email',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryDark.withValues(alpha: 0.5),
                    border: Border.all(
                      color: AppTheme.lightGray,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'user@example.com',
                        style: AppTheme.bodyRegular,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.successGreen,
                        size: context.rw(20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                // Password Input
                Text(
                  'Password',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextField(
                  controller: _passwordController,
                  style: AppTheme.bodyRegular,
                  obscureText: true,
                  cursorColor: AppTheme.white,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: AppTheme.bodySmall,
                    filled: true,
                    fillColor: AppTheme.primaryDark.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppTheme.white,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.015,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.06),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: context.rh(48),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate directly to loading screen and pass a message
                      Navigator.pushReplacementNamed(context, '/loading', arguments: 'Logging in (no backend)');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Log In',
                      style: AppTheme.buttonText.copyWith(
                        color: AppTheme.primaryTeal,
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

