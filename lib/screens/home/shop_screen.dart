import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../widgets/app_header_search.dart';
import '../../widgets/category_item.dart';
import 'sub_category_screen.dart';

class ShopScreen extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavTap;
  final VoidCallback? onBackTap;

  const ShopScreen({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
    this.onBackTap,
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
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.04 - 4,
                bottom: 4,
              ),
              child: GestureDetector(
                onTap: () {
                  if (onBackTap != null) {
                    onBackTap!();
                  } else {
                    onNavTap(0);
                  }
                },


                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 24,
                    color: Color(0xFF587B7F),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mockCategories.length,
                itemBuilder: (context, index) {
                  final category = mockCategories[index];
                  return CategoryItem(
                    category: category,
                    variant: CategoryItemVariant.listTile,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
