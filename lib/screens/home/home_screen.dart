import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';
import 'shop_screen.dart';
import 'basket_screen.dart';
import 'more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildHomeTab(),
        ShopScreen(
          currentIndex: _selectedIndex,
          onNavTap: _onBottomNavTapped,
        ),
        _buildMyWorkspaceTab(),
        _buildBasketTab(),
        _buildMoreTab(),
      ],
    );
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomeTab() {
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop Categories',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(12),
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'See all',
                        style: AppTheme.dmSans(
                          fontSize: context.rf(8),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400] ?? Colors.grey,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
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
                      return _buildCategoryItem(category);
                    },
                  ),
                ),
                const SizedBox(height: 28),
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
                SizedBox(
                  height: context.rh(240),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockProducts.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(10)),
                    itemBuilder: (context, index) {
                      final product = mockProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: context.rh(180),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockPromotions.length,
                    separatorBuilder: (_, __) => SizedBox(width: context.rw(10)),
                    itemBuilder: (context, index) {
                      final promotion = mockPromotions[index];
                      return _buildPromotionBanner(promotion);
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildCategoryItem(Category category) {
    return Column(
      children: [
        // Container(
        //   width: 72,
        //   height: 72,
        //   decoration: BoxDecoration(
        //     color: const Color(0xFF5A8A7F).withValues(alpha: 0.15),
        //     shape: BoxShape.circle,
        //     border: Border.all(
        //       color: const Color(0xFF5A8A7F).withValues(alpha: 0.08),
        //       width: 1,
        //     ),
        //   ),
        //   child: Center(
        //     child: Text(
        //       category.icon,
        //       style: const TextStyle(fontSize: 28),
        //     ),
        //   ),
        // ),

        Container(
          width: context.rw(72),
          height: context.rw(72),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(category.backgroundImage),
              fit: BoxFit.cover,
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
              color: Color(0xFF345556),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      width: context.rw(145),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Stack(
            children: [
              Container(
                height: context.rh(115),
                width: context.rw(140),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  child: Image.asset(
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
              Positioned(
                top: context.rh(8),
                right: context.rw(8),
                child: Container(
                  width: context.rw(20),
                  height: context.rw(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: context.rw(12),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
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
                    fontSize: context.rf(8),
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.rh(3)),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xff6F8E95),
                      size: context.rw(6),
                    ),
                    SizedBox(width: context.rw(4)),

                    Text(
                      '5.0 Rating',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(6),
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.rh(5)),

                Text(
                  'Requires 2 days notice',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(6),
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: context.rh(10)),

                Text(
                  product.price,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(10),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryTeal,
                  ),
                ),
                SizedBox(height: context.rh(6)),
                SizedBox(
                  width: context.rw(145),
                  height: context.rh(24),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryTeal,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
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

  Widget _buildPromotionBanner(Promotion promotion) {
    return Container(
      width: context.rw(280),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Color(int.parse('0xFF${promotion.backgroundColor.substring(1)}')),
      ),
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                image: AssetImage(promotion.backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.4),
                  BlendMode.multiply,
                ),
              ),
            ),
          ),
          // Text overlay
          Padding(
            padding: EdgeInsets.all(context.rw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.rw(220),
                  child: Text(
                    promotion.title,
                    style: AppTheme.newsreader(
                      fontSize: context.rf(16),
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.subtitle,
                      style: AppTheme.dmSans(
                        fontSize: context.rf(11),
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rh(12)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.rw(10),
                        vertical: context.rh(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        promotion.buttonText,
                        style: AppTheme.dmSans(
                          fontSize: context.rf(11),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyWorkspaceTab() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'My Workspace',
            style: AppTheme.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildBasketTab() {
    return BasketScreen(
      currentNavIndex: _selectedIndex,
      onNavTap: _onBottomNavTapped,
    );
  }

  Widget _buildMoreTab() {
    return MoreScreen(
      currentNavIndex: _selectedIndex,
      onNavTap: _onBottomNavTapped,
    );
  }
}

