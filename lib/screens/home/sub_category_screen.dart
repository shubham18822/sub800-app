import 'package:flutter/material.dart';
import '../../config/routes.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import 'product_browsing_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final Category category;
  final int currentNavIndex;
  final Function(int) onNavTap;

  const SubCategoryScreen({
    super.key,
    required this.category,
    required this.currentNavIndex,
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
                    // color: Colors.black54,
                    color: Color(0xFF587B7F),
                  ),
                ),
              ),
            ),

            // Subcategory list
            Expanded(
              child: ListView.builder(
                itemCount: category.subcategories.length,
                itemBuilder: (context, index) {
                  final sub = category.subcategories[index];
                  return _buildSubCategoryItem(context, sub);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: (i) {
          onNavTap(i);
          Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
        },
      ),
    );
  }

  Widget _buildSubCategoryItem(BuildContext context, Subcategory sub) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (sub.name == 'Catering') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductBrowsingScreen(
                    title: 'Catering',
                    resultsText: '24 results',
                    products: mockCateringProducts,
                    currentNavIndex: currentNavIndex,
                    onNavTap: onNavTap,
                  ),
                ),
              );
            } else if (sub.name == 'Desk Chairs') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductBrowsingScreen(
                    title: 'Desk Chairs',
                    resultsText: '12 results',
                    products: mockFurnitureProducts,
                    currentNavIndex: currentNavIndex,
                    onNavTap: onNavTap,
                  ),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.rw(20), vertical: context.rh(14)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    sub.name,
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
