import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_logo.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Top row: logo left + search field center + close button right
                Row(
                  children: [
                    const AppLogo(),
                    SizedBox(width: context.rw(12)),
                    Expanded(
                      child: Container(
                        height: context.rh(42),
                        padding: EdgeInsets.symmetric(horizontal: context.rw(12)),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(context.rw(20)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: context.rw(18), color: Colors.grey),
                            SizedBox(width: context.rw(8)),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Search here',
                                  border: InputBorder.none,
                                  hintStyle: AppTheme.dmSans(
                                    fontSize: context.rf(14),
                                    color: Colors.grey[500] ?? Colors.grey,
                                  ),
                                ),
                                style: AppTheme.dmSans(fontSize: context.rf(14), color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: context.rw(8)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: context.rw(36),
                        height: context.rw(36),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(context.rw(18)),
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                        ),
                        child: Center(
                          child: Icon(Icons.close, size: context.rw(18), color: Colors.black54),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                // Welcome heading
                Text(
                  'Welcome back, Lauren',
                  style: AppTheme.newsreader(
                    fontSize: context.rf(24),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.primaryTeal,
                  ),
                ),

                const SizedBox(height: 20),

                // "Shop Categories" header with "See all" link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop Categories',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(14),
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'See all',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(12),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600] ?? Colors.grey,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Categories (horizontal scrolling)
                SizedBox(
                  height: context.rh(115),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategories.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(8)),
                    itemBuilder: (context, index) {
                      final category = mockCategories[index];
                      return _buildCategoryItem(context, category);
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // New Arrivals heading
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
                  'Discover the newest addition to your office well being',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600] ?? Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                // Horizontal product cards
                SizedBox(
                  height: context.rh(220),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockProducts.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(10)),
                    itemBuilder: (context, index) {
                      final product = mockProducts[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Promotional banners (2 side by side)
                SizedBox(
                  height: context.rh(180),
                  child: Row(
                    children: [
                      // Left banner (beige/tan)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFC9B8A3),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(context.rw(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: context.rw(140),
                                      child: Text(
                                        'Explore Signature Scents for Your Office',
                                        style: AppTheme.newsreader(
                                          fontSize: context.rf(16),
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Bring a sense of calm to your workspace',
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(11),
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: context.rw(10), vertical: context.rh(6)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Discover',
                                        style: AppTheme.dmSans(
                                          fontSize: context.rf(11),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: context.rw(10)),
                      // Right banner (dark blue/black)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF2C3E50),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(context.rw(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: context.rw(140),
                                      child: Text(
                                        'New Collection Now Available',
                                        style: AppTheme.newsreader(
                                          fontSize: context.rf(16),
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Celebrate with our premium packages',
                                      style: AppTheme.dmSans(
                                        fontSize: context.rf(11),
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: context.rw(10), vertical: context.rh(6)),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                      ),
                                      child: Text(
                                        'Explore',
                                        style: AppTheme.dmSans(
                                          fontSize: context.rf(11),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildCategoryItem(BuildContext context, Category category) {
    return Column(
      children: [
        Container(
          width: context.rw(72),
          height: context.rw(72),
          decoration: BoxDecoration(
            color: const Color(0xFF5A8A7F).withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF5A8A7F).withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              category.icon,
              style: TextStyle(fontSize: context.rf(28)),
            ),
          ),
        ),
        SizedBox(height: context.rh(8)),
        SizedBox(
          width: context.rw(78),
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: AppTheme.dmSans(
              fontSize: context.rf(11),
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Container(
      width: context.rw(145),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Container(
            height: context.rh(105),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.rw(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(11),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.rh(4)),
                Text(
                  product.price,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(11),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryTeal,
                  ),
                ),
                SizedBox(height: context.rh(6)),
                SizedBox(
                  width: double.infinity,
                  height: context.rh(24),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTeal,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(10),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

