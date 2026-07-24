import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/category_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;
  final Map<String, String> deliveryDate;
  final String deliveryAddress;

  const OrderConfirmationScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
    required this.deliveryDate,
    required this.deliveryAddress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final items = globalCart.isNotEmpty
        ? globalCart
        : [
            CartItem(product: mockProducts[0], quantity: 1),
            CartItem(product: mockProducts[1], quantity: 1),
          ];

    final dateString =
        '${deliveryDate['day'] ?? 'Monday'} 8th ${deliveryDate['month'] ?? 'June'} 2026';

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
                const AppHeaderSearch(padding: EdgeInsets.zero),
                SizedBox(height: context.rh(20)),

                // Screen Title (Newsreader Italic)
                Center(
                  child: Text(
                    'Order Confirmation',
                    style: AppTheme.newsreader(
                      fontSize: context.rf(22),
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF1F2023),
                    ),
                  ),
                ),
                SizedBox(height: context.rh(28)),

                // Purchased Items Summary
                ...items.map((cartItem) => _buildPurchasedItemCard(context, cartItem)),

                SizedBox(height: context.rh(28)),

                // Delivery Information Section
                Text(
                  'Delivery Information',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(14),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2023),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: context.rh(10)),
                Text(
                  dateString,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(11),
                    color: const Color(0xFF1F2023),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: context.rh(4)),
                Text(
                  deliveryAddress.isNotEmpty
                      ? deliveryAddress
                      : '3rd Floor, 20-22 Vestry Street, London, EC1M 4AN',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(11),
                    color: const Color(0xFF1F2023),
                    height: 1.3,
                  ),
                ),

                SizedBox(height: context.rh(36)),

                // Continue Shopping Button
                SizedBox(
                  width: double.infinity,
                  height: context.rh(40),
                  child: ElevatedButton(
                    onPressed: () {
                      globalCart.clear();
                      notifyCartChanged();
                      onNavTap(0);
                      Navigator.of(context)
                          .popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF587B7F),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: Text(
                      'Continue Shopping',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(12),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: context.rh(40)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: (i) {
          onNavTap(i);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildPurchasedItemCard(BuildContext context, CartItem cartItem) {
    final imageWidth = context.rw(120);

    return Container(
      margin: EdgeInsets.only(bottom: context.rh(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: imageWidth,
            height: imageWidth,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F4),
              borderRadius: BorderRadius.zero,
            ),
            child: ClipRRect(
              child: Image.asset(
                cartItem.product.image,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) {
                  return Icon(
                    Icons.local_florist,
                    size: context.rw(40),
                    color: const Color(0xFF587B7F),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: context.rw(16)),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F2023),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: context.rh(4)),
                Text(
                  '£${cartItem.product.price}',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2023),
                  ),
                ),
                SizedBox(height: context.rh(12)),
                RichText(
                  text: TextSpan(
                    style: AppTheme.dmSans(
                      fontSize: context.rf(9),
                      color: const Color(0xFF1F2023),
                    ),
                    children: const [
                      TextSpan(text: 'Colour: '),
                      TextSpan(
                        text: 'Pinks',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.rh(2)),
                Text(
                  'Qty: ${cartItem.quantity}',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(9),
                    color: const Color(0xFF1F2023),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
