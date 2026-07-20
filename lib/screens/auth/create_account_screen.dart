import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/responsive.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _designationController.dispose();
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
                SizedBox(height: size.height * 0.06),

                // Heading (using Playfair Display)
                Text(
                  'Create your\naccount,',
                  style: AppTheme.newsreader(
                    fontSize: context.rf(59, minScale: 0.6, maxScale: 1.0),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.white,
                    height: 1,
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Subtitle (using Playfair Display)
                Text(
                  'Manage your office space through one place via the sub800 app',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(16),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.lightGray,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                // Input fields (placeholders inside boxes to match Figma)
                _buildInputField('First Name', _firstNameController, size),
                SizedBox(height: size.height * 0.02),
                _buildInputField('Last Name', _lastNameController, size),
                SizedBox(height: size.height * 0.02),
                _buildInputField('Job Title', _designationController, size),
                SizedBox(height: size.height * 0.02),
                _buildInputField('Company Name', _companyController, size),
                SizedBox(height: size.height * 0.02),
                _buildInputField('Email Address', _emailController, size),
                SizedBox(height: size.height * 0.02),
                _buildInputField('Phone Number', _phoneController, size),
                SizedBox(height: size.height * 0.06),

                // Previous and Next buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.40,
                      height: context.rh(40),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTheme.dmSans(
                            color: AppTheme.primaryTeal,
                            fontSize: context.rf(13),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: size.width * 0.40,
                      height: context.rh(40),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/office_interests');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Next',
                          style: AppTheme.dmSans(
                            color: AppTheme.primaryTeal,
                            fontSize: context.rf(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller, Size size) {
    // Figma-style input: placeholder inside, thin white outline, transparent fill
    return SizedBox(
        height: size.height * 0.05,
        child:TextField(
      controller: controller,
      style: AppTheme.bodyRegular.copyWith(color: AppTheme.white),
      cursorColor: AppTheme.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTheme.bodySmall.copyWith(color: AppTheme.white.withValues(alpha: 0.8), fontSize: size.width * 0.042),
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
          vertical: size.height * 0.010,
        ),
      ),
        ),
    );
  }
}

