import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo with sub800 text
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/wlogo.png',
                      height: 32,
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
                SizedBox(height: size.height * 0.08),

                // Heading (using Playfair Display)
                Text(
                  'Create your\npassword,',
                  style: GoogleFonts.newsreader(
                    textStyle: AppTheme.heading1.copyWith(
                      fontSize: 59,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Subtitle (using Playfair Display)
                Text(
                  'Manage your office space through one place via the sub800 app',
                  style: GoogleFonts.dmSans(
                    textStyle: AppTheme.subtitle.copyWith(
                      color: AppTheme.lightGray,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.08),

                // Password Input
                SizedBox(
                  height: 35,
                  child: TextField(
                  controller: _passwordController,
                  style: AppTheme.bodyRegular.copyWith(color: AppTheme.white),
                  obscureText: !_showPassword,
                  cursorColor: AppTheme.white,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: AppTheme.bodySmall.copyWith(color: AppTheme.white.withValues(alpha: 0.8)),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: AppTheme.white.withValues(alpha: 0.6),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: AppTheme.white.withValues(alpha: 0.6),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: AppTheme.white.withValues(alpha: 0.95),
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.012,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.white.withValues(alpha: 0.7),
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                  ),
                ),
                ),
                SizedBox(height: size.height * 0.03),

                // Confirm Password Input
                SizedBox(
                  height: 35,
                  child: TextField(
                  controller: _confirmPasswordController,
                  style: AppTheme.bodyRegular.copyWith(color: AppTheme.white),
                  obscureText: !_showConfirmPassword,
                  cursorColor: AppTheme.white,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: AppTheme.bodySmall.copyWith(color: AppTheme.white.withValues(alpha: 0.8)),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: AppTheme.lightGray,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: AppTheme.lightGray,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.012,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: IconButton(
                        icon: Icon(
                          _showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.white.withValues(alpha: 0.7),
                        ),
                        onPressed: () {
                          setState(() =>
                              _showConfirmPassword = !_showConfirmPassword);
                        },
                      ),
                    ),
                  ),
                ),
                ),
                SizedBox(height: size.height * 0.06),

                // Previous and Submit buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 145,
                      height: 37,
                      child: ElevatedButton(
                        onPressed: () {
                          // Go back to Office Interests
                          Navigator.pushReplacementNamed(context, Routes.officeInterests);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Previous',
                          style: AppTheme.buttonText.copyWith(
                            color: AppTheme.primaryTeal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 145,
                      height: 37,
                      child: ElevatedButton(
                        onPressed: () async {
                          final pwd = _passwordController.text.trim();
                          final confirm = _confirmPasswordController.text.trim();
                          if (pwd.isEmpty || confirm.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Please enter and confirm your password'),
                                backgroundColor: AppTheme.errorRed,
                              ),
                            );
                            return;
                          }
                          if (pwd != confirm) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Passwords do not match'),
                                backgroundColor: AppTheme.errorRed,
                              ),
                            );
                            return;
                          }

                          // Mock submit: show success, then go to login screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created successfully!'),
                              backgroundColor: AppTheme.successGreen,
                            ),
                          );

                          await Future.delayed(const Duration(milliseconds: 800));
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Submit',
                          style: AppTheme.buttonText.copyWith(
                            color: AppTheme.primaryTeal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

