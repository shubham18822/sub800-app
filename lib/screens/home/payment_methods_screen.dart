import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_header_search.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final int currentNavIndex;
  final Function(int) onNavTap;

  const PaymentMethodsScreen({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

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
                const AppHeaderSearch(
                  padding: EdgeInsets.zero,
                ),
                SizedBox(height: context.rh(28)),

                // ── Saved Payment Methods ────────────────────────────────────
                Text(
                  'Saved Payment Methods',
                  style: AppTheme.dmSans(
                    fontSize: context.rf(14),
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
                SizedBox(height: context.rh(20)),

                // Card details
                _buildPaymentField(context, 'Card Number', '234234 5434 241341'),
                _buildPaymentField(context, 'Expiry Date', '01/2028'),
                _buildPaymentField(context, 'CVV Number', '231'),
                _buildPaymentField(context, 'Name on Card', 'Mrs Lauren Matthews'),

                SizedBox(height: context.rh(32)),

                // ── Shipping Addresses ───────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Addresses',
                      style: AppTheme.dmSans(
                        fontSize: context.rf(14),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      size: context.rw(18),
                      color: AppTheme.primaryTeal,
                    ),
                  ],
                ),
                SizedBox(height: context.rh(20)),

                // Address card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.rw(130),
                            child: Text(
                              'Name',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(11),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7A9AA0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Lauren Matthews',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(11),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7A9AA0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.rh(16)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.rw(130),
                            child: Text(
                              'Address',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(11),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7A9AA0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '47–53 St John\'s Street, London, EC1M 4AN',
                              style: AppTheme.dmSans(
                                fontSize: context.rf(11),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7A9AA0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

  Widget _buildPaymentField(
    BuildContext context,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.rh(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.rw(120),
            child: Text(
              label,
              style: AppTheme.dmSans(
                fontSize: context.rf(11),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A9AA0),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.dmSans(
                fontSize: context.rf(11),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A9AA0),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

