import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_header_search.dart';
import '../../widgets/category_item.dart';
import '../../widgets/product_card.dart';
import '../../widgets/promotion_banner.dart';
import '../../widgets/section_header.dart';
import 'product_browsing_screen.dart';

class HomeScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int)? onNavTap;

  const HomeScreen({
    super.key,
    this.currentNavIndex = 0,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const AppHeaderSearch(
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),

                // "Welcome back, Lauren" Header
                RichText(
                  text: TextSpan(
                    style: AppTheme.newsreader(
                      fontSize: context.rf(24),
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Welcome back, ',
                        style: TextStyle(color: Colors.black87),
                      ),
                      TextSpan(
                        text: 'Lauren',
                        style: AppTheme.newsreader(
                          fontSize: context.rf(24),
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF345556),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Shop Categories Header & Horizontal List
                SectionHeader(
                  title: 'Shop Categories',
                  actionLabel: 'See all',
                  onActionTap: () {},
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: context.rh(115),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategories.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(8)),
                    itemBuilder: (context, index) {
                      final category = mockCategories[index];
                      return CategoryItem(
                        category: category,
                        variant: CategoryItemVariant.circle,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductBrowsingScreen(
                                title: category.name,
                                resultsText: '12 items',
                                products: mockProducts,
                                currentNavIndex: currentNavIndex,
                                onNavTap: onNavTap ?? (_) {},
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // New Arrivals Section
                Text(
                  'New Arrivals',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(15),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Discover the newest arrivals to the sub800 shop for your office and team',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600] ?? Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),

                // Product Cards Horizontal List with exact height matching original UI
                SizedBox(
                  height: context.rh(240),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockProducts.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(10)),
                    itemBuilder: (context, index) {
                      final product = mockProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {},
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Promotion Banners List
                SizedBox(
                  height: context.rh(180),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockPromotions.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(10)),
                    itemBuilder: (context, index) {
                      final promotion = mockPromotions[index];
                      return PromotionBanner(
                        promotion: promotion,
                        onTap: () {},
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
