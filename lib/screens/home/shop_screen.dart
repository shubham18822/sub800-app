import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import 'sub_category_screen.dart';

class ShopScreen extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavTap;

  const ShopScreen({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeaderSearch(),

            // "Shop Categories" label
            // Padding(
            //   padding: EdgeInsets.only(
            //     left: size.width * 0.05,
            //     bottom: 8,
            //   ),
            //   child: Text(
            //     'Shop Categories',
            //     style: GoogleFonts.dmSans(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black54,
            //     ),
            //   ),
            // ),

            // Back arrow
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.04 - 4,
                bottom: 4,
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 24,
                    // color: Colors.black12,
                    color: const Color(0xFF587B7F),
                  ),
                ),
              ),
            ),

            // Categories list
            Expanded(
              child: ListView.builder(
                itemCount: mockCategories.length,
                itemBuilder: (context, index) {
                  final category = mockCategories[index];
                  return _buildCategoryItem(context, category);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, Category category) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SubCategoryScreen(
                  category: category,
                  currentNavIndex: currentIndex,
                  onNavTap: onNavTap,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rw(20), vertical: context.rh(14)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    style: AppTheme.dmSans(
                      fontSize: context.rf(13),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF345556),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey[400],
                  size: context.rw(20),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          indent: context.rw(20),
          endIndent: 0,
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}


