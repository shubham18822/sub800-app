import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class OfficeInterestsScreen extends StatefulWidget {
  const OfficeInterestsScreen({super.key});

  @override
  State<OfficeInterestsScreen> createState() => _OfficeInterestsScreenState();
}

class _OfficeInterestsScreenState extends State<OfficeInterestsScreen> {
  final List<InterestItem> interests = [
    InterestItem(id: 1, label: 'Flexible Space', isSelected: false),
    InterestItem(id: 2, label: 'Coworking', isSelected: false),
    InterestItem(id: 3, label: 'Private Cabin', isSelected: false),
    InterestItem(id: 4, label: 'Food & Breeverage', isSelected: false),
    InterestItem(id: 5, label: 'Event Space', isSelected: false),
    InterestItem(id: 6, label: 'Training', isSelected: false),
    InterestItem(id: 7, label: 'Kitchen', isSelected: false),
    InterestItem(id: 8, label: 'Discounts', isSelected: false),
    InterestItem(id: 9, label: 'High-Speed WiFi', isSelected: false),
    InterestItem(id: 10, label: 'Security', isSelected: false),
    InterestItem(id: 11, label: 'Networking', isSelected: false),
    InterestItem(id: 12, label: 'Virtual Assistance', isSelected: false),
  ];

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

                // Heading (using Playfair Display like login page)
                Text(
                  'Office\nInterests...',
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
                SizedBox(height: size.height * 0.04),

                // Interest Grid - outlined chip style like Figma
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size.width * 0.01,
                    mainAxisSpacing: size.height * 0.01,
                    // childAspectRatio: 3.2,
                    mainAxisExtent: 35,
                  ),
                  itemCount: interests.length,
                  itemBuilder: (context, index) {
                    final interest = interests[index];
                    return GestureDetector(
                      onTap: () => setState(() => interest.isSelected = !interest.isSelected),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        decoration: BoxDecoration(
                          color: interest.isSelected ? AppTheme.white : Colors.transparent,
                          border: Border.all(
                            color: AppTheme.white.withValues(alpha: 0.9),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Circle checkbox
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: interest.isSelected ? AppTheme.primaryTeal : AppTheme.white,
                                  width: 1.5,
                                ),
                                color: interest.isSelected ? AppTheme.primaryTeal : Colors.transparent,
                              ),
                              child: interest.isSelected
                                  ? const Icon(Icons.check, size: 10, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: size.width * 0.04),
                            Expanded(
                              child: Text(
                                interest.label,
                                style: AppTheme.bodySmall.copyWith(
                                  color: interest.isSelected ? AppTheme.textDark : AppTheme.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.06),

                // Previous and Next buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 145,
                      height: 37,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          elevation: 2,
                        ),
                        child: Text(
                          'Previous',
                          style: AppTheme.buttonText.copyWith(color: AppTheme.primaryTeal, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 145,
                      height: 37,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/create_password');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          elevation: 2,
                        ),
                        child: Text(
                          'Next',
                          style: AppTheme.buttonText.copyWith(color: AppTheme.primaryTeal, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestItem {
  final int id;
  final String label;
  bool isSelected;

  InterestItem({
    required this.id,
    required this.label,
    required this.isSelected,
  });
}

