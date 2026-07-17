import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/routes.dart';
import '../../models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

                // Top row: left logo (32px) and right search icon
                Row(
                  children: [
                    Image.asset('assets/logo.png', height: 32, fit: BoxFit.contain),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.search),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                        ),
                        child: const Center(child: Icon(Icons.search, size: 18, color: Colors.black54)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Welcome heading
                Text(
                  'Welcome back, Aditya',
                  style: GoogleFonts.newsreader(
                    textStyle: const TextStyle(color: AppTheme.primaryTeal),
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                // "Shop Categories" header with "See all" link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop Categories',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'See all',
                        style: GoogleFonts.dmSans(
                          fontSize: 6,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Categories (horizontal scrolling circles with real names)
                SizedBox(
                  height: 115,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = mockCategories[index];
                      return _buildCategoryItem(category);
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // New Arrivals heading
                Text(
                  'New Arrivals',
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Discover the newest addition to your office well being',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 12),

                // Horizontal product cards
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final product = mockProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Promotional banners (2 side by side)
                SizedBox(
                  height: 180,
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
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Text(
                                        'Explore Signature Scents for Your Office',
                                        style: GoogleFonts.newsreader(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Bring a sense of calm to your workspace',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Discover',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 11,
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
                      const SizedBox(width: 10),
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
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Text(
                                        'New Collection Now Available',
                                        style: GoogleFonts.newsreader(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Celebrate with our premium packages',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                      ),
                                      child: Text(
                                        'Explore',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 11,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryTeal,
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: 'My Workspace'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: 'Basket'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        currentIndex: 0,
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
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(category.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 78,
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 11,
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
      width: 145,
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
            height: 105,
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryTeal,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  height: 24,
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
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
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

